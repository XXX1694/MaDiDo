import 'package:isar/isar.dart';
import 'package:to_do/core/utils/hash_utils.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

part 'todo_model.g.dart';

@collection
class TodoModel {
  TodoModel();

  factory TodoModel.fromDomain(Todo todo) {
    return TodoModel()
      ..id = todo.id
      ..title = todo.title
      ..description = todo.description
      ..isCompleted = todo.isCompleted
      ..createdAt = todo.createdAt
      ..deadline = todo.deadline
      ..priority = todo.priority
      ..categoryId = todo.categoryId
      ..isPinned = todo.isPinned;
  }

  Id get isarId => fastHash(id);

  @Index(unique: true, replace: true)
  late String id;

  late String title;
  String? description;
  late bool isCompleted;
  @Index()
  late DateTime createdAt;
  DateTime? deadline;

  @Enumerated(EnumType.ordinal)
  TodoPriority priority = TodoPriority.medium;

  String? categoryId;

  bool isPinned = false;

  Todo toDomain() {
    return Todo(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: createdAt,
      deadline: deadline,
      priority: priority,
      categoryId: categoryId,
      isPinned: isPinned,
    );
  }
}
