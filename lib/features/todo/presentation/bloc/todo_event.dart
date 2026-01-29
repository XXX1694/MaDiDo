import 'package:equatable/equatable.dart';
import 'package:to_do/features/todo/domain/entities/sort_option.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodosSubscriptionRequested extends TodoEvent {}

class TodoAdded extends TodoEvent {
  const TodoAdded(this.todo);
  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

class TodoCompletionToggled extends TodoEvent {
  const TodoCompletionToggled({required this.todo, required this.isCompleted});
  final Todo todo;
  final bool isCompleted;

  @override
  List<Object?> get props => [todo, isCompleted];
}

class TodoUpdated extends TodoEvent {
  const TodoUpdated(this.todo);
  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

class TodoDeleted extends TodoEvent {
  const TodoDeleted(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}

class TodosSortChanged extends TodoEvent {
  const TodosSortChanged(this.sortOption);
  final SortOption sortOption;

  @override
  List<Object?> get props => [sortOption];
}

class TodosFilterChanged extends TodoEvent {
  const TodosFilterChanged({this.categoryId, this.priority, this.isCompleted});
  final String? categoryId;
  final TodoPriority? priority;
  final bool? isCompleted;

  @override
  List<Object?> get props => [categoryId, priority, isCompleted];
}

class TodosListUpdated extends TodoEvent {
  const TodosListUpdated(this.todos);
  final List<Todo> todos;

  @override
  List<Object?> get props => [todos];
}
