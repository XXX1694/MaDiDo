import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  }) : super(const TodoState()) {
    on<TodosSubscriptionRequested>(_onSubscriptionRequested);
    on<TodosListUpdated>(_onTodosListUpdated);
    on<TodosFilterChanged>(_onFilterChanged);
    on<TodoAdded>(_onTodoAdded);
    on<TodoUpdated>(_onTodoUpdated);
    on<TodoCompletionToggled>(_onTodoCompletionToggled);
    on<TodoDeleted>(_onTodoDeleted);
    on<TodosSortChanged>(_onSortChanged);
  }
  final WatchTodosUseCase watchTodosUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

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
    await addTodoUseCase(event.todo);
  }

  Future<void> _onTodoCompletionToggled(
    TodoCompletionToggled event,
    Emitter<TodoState> emit,
  ) async {
    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await updateTodoUseCase(newTodo);
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
    await deleteTodoUseCase(event.id);
  }
}
