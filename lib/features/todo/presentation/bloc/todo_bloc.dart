import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/core/services/review_service.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:to_do/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:to_do/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:to_do/features/todo/domain/usecases/watch_todos_usecase.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_event.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_state.dart';
import 'package:to_do/features/todo/presentation/utils/todo_sorter.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({
    required this.watchTodosUseCase,
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
    required this.reviewService,
  }) : super(const TodoState()) {
    on<TodosSubscriptionRequested>(_onSubscriptionRequested);
    on<TodosListUpdated>(_onTodosListUpdated);
    on<TodosFilterChanged>(_onFilterChanged);
    on<TodoAdded>(_onTodoAdded);
    on<TodoUpdated>(_onTodoUpdated);
    on<TodoCompletionToggled>(_onTodoCompletionToggled);
    on<TodoDeleted>(_onTodoDeleted);
    on<TodosSortChanged>(_onSortChanged);
    on<TodoCompletionAnimationFinished>(_onTodoCompletionAnimationFinished);
  }
  final WatchTodosUseCase watchTodosUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final ReviewService reviewService;

  StreamSubscription<List<Todo>>? _todosSubscription;

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }

  Future<void> _onSubscriptionRequested(
    TodosSubscriptionRequested event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(status: TodoStatus.loading));

    await _todosSubscription?.cancel();
    _todosSubscription =
        watchTodosUseCase(
          categoryId: state.filterCategoryId,
          priority: state.filterPriority,
          isCompleted: state.filterIsCompleted,
        ).listen(
          (todos) => add(TodosListUpdated(todos)),
          onError: (Object error) => emit(
            state.copyWith(
              status: TodoStatus.failure,
              errorMessage: error.toString(),
            ),
          ),
        );
  }

  Future<void> _onTodosListUpdated(
    TodosListUpdated event,
    Emitter<TodoState> emit,
  ) async {
    final sorted = TodoSorter.sort(event.todos, state.sortOption);
    emit(state.copyWith(status: TodoStatus.success, todos: sorted));
  }

  Future<void> _onFilterChanged(
    TodosFilterChanged event,
    Emitter<TodoState> emit,
  ) async {
    emit(
      state.copyWith(
        filterCategoryId: event.categoryId,
        clearFilterCategoryId: event.categoryId == null,
        filterPriority: event.priority,
        clearFilterPriority: event.priority == null,
        filterIsCompleted: event.isCompleted,
        clearFilterIsCompleted: event.isCompleted == null,
      ),
    );
    add(TodosSubscriptionRequested());
  }

  Future<void> _onSortChanged(
    TodosSortChanged event,
    Emitter<TodoState> emit,
  ) async {
    final sorted = TodoSorter.sort(state.todos, event.sortOption);
    emit(state.copyWith(todos: sorted, sortOption: event.sortOption));
  }

  Future<void> _onTodoAdded(TodoAdded event, Emitter<TodoState> emit) async {
    // Optimistically add to list
    final updatedTodos = List<Todo>.from(state.todos)..add(event.todo);
    // Sort the list properly after adding
    final sortedTodos = TodoSorter.sort(updatedTodos, state.sortOption);
    emit(state.copyWith(todos: sortedTodos));

    try {
      await addTodoUseCase(event.todo);
    } catch (e) {
      // Revert if needed, though subscription will handle it
    }
  }

  Future<void> _onTodoCompletionToggled(
    TodoCompletionToggled event,
    Emitter<TodoState> emit,
  ) async {
    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await updateTodoUseCase(newTodo);
    if (event.isCompleted) {
      await reviewService.incrementCompletedTasks();
    }
  }

  Future<void> _onTodoUpdated(
    TodoUpdated event,
    Emitter<TodoState> emit,
  ) async {
    await updateTodoUseCase(event.todo);
  }

  Future<void> _onTodoDeleted(
    TodoDeleted event,
    Emitter<TodoState> emit,
  ) async {
    // Optimistically remove from list to avoid Dismissible error
    final updatedTodos = state.todos
        .where((todo) => todo.id != event.id)
        .toList();
    emit(state.copyWith(todos: updatedTodos));

    try {
      await deleteTodoUseCase(event.id);
    } catch (e) {
      // If error occurs, the subscription will restore the real state,
      // but we could also emit an error state here if needed.
    }
  }

  Future<void> _onTodoCompletionAnimationFinished(
    TodoCompletionAnimationFinished event,
    Emitter<TodoState> emit,
  ) async {
    // If the flag is already true, this event resets it back to false
    // after the UI has seen it.
    if (state.showReviewDialog) {
      emit(state.copyWith(showReviewDialog: false));
    } else {
      // Logic from _checkReview moved here conceptually
      if (await reviewService.shouldShowReview()) {
        emit(state.copyWith(showReviewDialog: true));
      }
    }
  }
}
