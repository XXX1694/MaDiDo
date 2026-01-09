import 'package:to_do/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:to_do/features/todo/data/models/todo_model.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';

import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Stream<List<Todo>> watchTodos({
    String? categoryId,
    TodoPriority? priority,
    bool? isCompleted,
  }) {
    return localDataSource
        .watchTodos(
          categoryId: categoryId,
          priority: priority,
          isCompleted: isCompleted,
        )
        .map((models) {
          return models.map((e) => e.toDomain()).toList();
        });
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final model = TodoModel.fromDomain(todo);
    await localDataSource.addTodo(model);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final model = TodoModel.fromDomain(todo);
    await localDataSource.updateTodo(model);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await localDataSource.deleteTodo(id);
  }
}
