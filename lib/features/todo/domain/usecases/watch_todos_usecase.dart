import 'package:to_do/features/todo/domain/entities/todo.dart';

import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';

import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

class WatchTodosUseCase {
  final TodoRepository repository;

  WatchTodosUseCase(this.repository);

  Stream<List<Todo>> call({
    String? categoryId,
    TodoPriority? priority,
    bool? isCompleted,
  }) {
    return repository.watchTodos(
      categoryId: categoryId,
      priority: priority,
      isCompleted: isCompleted,
    );
  }
}
