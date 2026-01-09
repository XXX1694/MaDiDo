import 'package:equatable/equatable.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/sort_option.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodosSubscriptionRequested extends TodoEvent {}

class TodoAdded extends TodoEvent {
  final Todo todo;

  const TodoAdded(this.todo);

  @override
  List<Object?> get props => [todo];
}

class TodoCompletionToggled extends TodoEvent {
  final Todo todo;
  final bool isCompleted;

  const TodoCompletionToggled({required this.todo, required this.isCompleted});

  @override
  List<Object?> get props => [todo, isCompleted];
}

class TodoUpdated extends TodoEvent {
  final Todo todo;

  const TodoUpdated(this.todo);

  @override
  List<Object?> get props => [todo];
}

class TodoDeleted extends TodoEvent {
  final String id;

  const TodoDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class TodosSortChanged extends TodoEvent {
  final SortOption sortOption;

  const TodosSortChanged(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}

class TodosFilterChanged extends TodoEvent {
  final String? categoryId;
  final TodoPriority? priority;
  final bool? isCompleted;

  const TodosFilterChanged({this.categoryId, this.priority, this.isCompleted});

  @override
  List<Object?> get props => [categoryId, priority, isCompleted];
}

class TodosListUpdated extends TodoEvent {
  final List<Todo> todos;

  const TodosListUpdated(this.todos);

  @override
  List<Object?> get props => [todos];
}
