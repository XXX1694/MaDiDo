import 'package:to_do/features/todo/domain/entities/todo.dart';

import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

abstract class TodoRepository {
  Stream<List<Todo>> watchTodos({
    String? categoryId,
    TodoPriority? priority,
    bool? isCompleted,
  });
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
}
