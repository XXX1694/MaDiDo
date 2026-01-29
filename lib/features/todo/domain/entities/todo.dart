import 'package:equatable/equatable.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

class Todo extends Equatable {
  const Todo({
    required this.id,
    required this.title,
    required this.createdAt,
    this.description,
    this.isCompleted = false,
    this.deadline,
    this.priority = TodoPriority.medium,
    this.categoryId,
    this.isPinned = false,
  });
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? deadline;

  final TodoPriority priority;
  final String? categoryId;
  final bool isPinned;

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? deadline,
    TodoPriority? priority,
    String? categoryId,
    bool? isPinned,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
      categoryId: categoryId ?? this.categoryId,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    isCompleted,
    createdAt,
    deadline,
    priority,
    categoryId,
    isPinned,
  ];
}
