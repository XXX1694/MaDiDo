import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';
import 'package:uuid/uuid.dart';

/// Factory for creating Todo entities
/// Centralizes and standardizes Todo creation logic
class TodoFactory {
  const TodoFactory._();

  static const _uuid = Uuid();

  /// Create a new Todo with the given parameters
  static Todo create({
    required String title,
    String? description,
    DateTime? deadline,
    TodoPriority priority = TodoPriority.medium,
    String? categoryId,
  }) {
    return Todo(
      id: _uuid.v4(),
      title: title.trim(),
      description: description?.trim().isEmpty == true
          ? null
          : description?.trim(),
      createdAt: DateTime.now(),
      deadline: deadline,
      priority: priority,
      categoryId: categoryId,
    );
  }

  /// Update an existing Todo with new values
  static Todo update({
    required Todo original,
    required String title,
    String? description,
    DateTime? deadline,
    TodoPriority? priority,
    String? categoryId,
  }) {
    return original.copyWith(
      title: title.trim(),
      description: description?.trim().isEmpty == true
          ? null
          : description?.trim(),
      deadline: deadline,
      priority: priority,
      categoryId: categoryId,
    );
  }
}
