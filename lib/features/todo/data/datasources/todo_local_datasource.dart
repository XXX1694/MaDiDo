import 'package:isar/isar.dart';
import 'package:to_do/features/todo/data/models/todo_model.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';
import 'package:to_do/core/utils/hash_utils.dart';

abstract class TodoLocalDataSource {
  Stream<List<TodoModel>> watchTodos({
    String? categoryId,
    TodoPriority? priority,
    bool? isCompleted,
  });
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  TodoLocalDataSourceImpl(this.isar);
  final Isar isar;

  @override
  Stream<List<TodoModel>> watchTodos({
    String? categoryId,
    TodoPriority? priority,
    bool? isCompleted,
  }) {
    return isar.todoModels
        .where()
        .filter()
        .optional(categoryId != null, (q) => q.categoryIdEqualTo(categoryId))
        .and()
        .optional(priority != null, (q) => q.priorityEqualTo(priority!))
        .and()
        .optional(
          isCompleted != null,
          (q) => q.isCompletedEqualTo(isCompleted!),
        )
        .sortByIsPinnedDesc()
        .thenByPriorityDesc()
        .thenByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    await isar.writeTxn(() async {
      await isar.todoModels.put(todo);
    });
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await isar.writeTxn(() async {
      await isar.todoModels.put(todo);
    });
  }

  @override
  Future<void> deleteTodo(String id) async {
    await isar.writeTxn(() async {
      // We use fastHash to get the int ID from the string GUID
      await isar.todoModels.delete(fastHash(id));
    });
  }
}
