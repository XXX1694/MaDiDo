import 'package:flutter_test/flutter_test.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';

void main() {
  group('Todo Entity Tests', () {
    test('Todo should be created with required fields', () {
      final todo = Todo(id: '1', title: 'Test Todo', createdAt: DateTime.now());

      expect(todo.id, '1');
      expect(todo.title, 'Test Todo');
      expect(todo.isCompleted, false);
      expect(todo.priority, TodoPriority.medium);
    });

    test('Todo copyWith should update fields correctly', () {
      final originalTodo = Todo(
        id: '1',
        title: 'Original',
        createdAt: DateTime.now(),
        priority: TodoPriority.low,
      );

      final updatedTodo = originalTodo.copyWith(
        title: 'Updated',
        priority: TodoPriority.high,
      );

      expect(updatedTodo.id, '1');
      expect(updatedTodo.title, 'Updated');
      expect(updatedTodo.priority, TodoPriority.high);
    });

    test('Todo should toggle completion status', () {
      final todo = Todo(
        id: '1',
        title: 'Test',
        createdAt: DateTime.now(),
        isCompleted: false,
      );

      final completedTodo = todo.copyWith(isCompleted: true);

      expect(todo.isCompleted, false);
      expect(completedTodo.isCompleted, true);
    });
  });

  group('TodoPriority Tests', () {
    test('TodoPriority should have correct values', () {
      expect(TodoPriority.values.length, 3);
      expect(TodoPriority.values, contains(TodoPriority.low));
      expect(TodoPriority.values, contains(TodoPriority.medium));
      expect(TodoPriority.values, contains(TodoPriority.high));
    });
  });
}
