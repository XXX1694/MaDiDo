import 'package:isar/isar.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

part 'todo_model.g.dart';

@collection
class TodoModel {
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

  static TodoModel fromDomain(Todo todo) {
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
}

int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
