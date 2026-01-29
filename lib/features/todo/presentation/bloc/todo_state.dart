import 'package:equatable/equatable.dart';
import 'package:to_do/features/todo/domain/entities/sort_option.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

enum TodoStatus { initial, loading, success, failure }

class TodoState extends Equatable {
  const TodoState({
    this.status = TodoStatus.initial,
    this.todos = const [],
    this.sortOption = SortOption.createdAt,
    this.errorMessage,
    this.filterCategoryId,
    this.filterPriority,
    this.filterIsCompleted,
  });
  final TodoStatus status;
  final List<Todo> todos;
  final SortOption sortOption;
  final String? errorMessage;
  final String? filterCategoryId;
  final TodoPriority? filterPriority;
  final bool? filterIsCompleted;

  Iterable<Todo> get pendingTodos => todos.where((todo) => !todo.isCompleted);
  Iterable<Todo> get completedTodos => todos.where((todo) => todo.isCompleted);

  TodoState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
    SortOption? sortOption,
    String? errorMessage,
    String? filterCategoryId,
    TodoPriority? filterPriority,
    bool? filterIsCompleted,
    bool clearFilterCategoryId = false,
    bool clearFilterPriority = false,
    bool clearFilterIsCompleted = false,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      sortOption: sortOption ?? this.sortOption,
      errorMessage: errorMessage ?? this.errorMessage,
      filterCategoryId: clearFilterCategoryId
          ? null
          : (filterCategoryId ?? this.filterCategoryId),
      filterPriority: clearFilterPriority
          ? null
          : (filterPriority ?? this.filterPriority),
      filterIsCompleted: clearFilterIsCompleted
          ? null
          : (filterIsCompleted ?? this.filterIsCompleted),
    );
  }

  @override
  List<Object?> get props => [
    status,
    todos,
    sortOption,
    errorMessage,
    filterCategoryId,
    filterPriority,
    filterIsCompleted,
  ];
}
