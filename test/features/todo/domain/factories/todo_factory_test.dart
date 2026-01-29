import 'package:flutter_test/flutter_test.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';
import 'package:to_do/features/todo/domain/factories/todo_factory.dart';

void main() {
  group('TodoFactory', () {
    group('create', () {
      test('creates todo with provided values', () {
        final now = DateTime.now();
        final deadline = now.add(const Duration(days: 1));

        final todo = TodoFactory.create(
          title: 'Test Todo',
          description: 'Test Description',
          priority: TodoPriority.high,
          categoryId: 'cat-123',
          deadline: deadline,
        );

        expect(todo.title, equals('Test Todo'));
        expect(todo.description, equals('Test Description'));
        expect(todo.priority, equals(TodoPriority.high));
        expect(todo.categoryId, equals('cat-123'));
        expect(todo.deadline, equals(deadline));
        expect(todo.isCompleted, isFalse);
        expect(todo.isPinned, isFalse);
      });

      test('trims whitespace from title and description', () {
        final todo = TodoFactory.create(
          title: '  Spaced Title  ',
          description: '  Spaced Description  ',
        );

        expect(todo.title, equals('Spaced Title'));
        expect(todo.description, equals('Spaced Description'));
      });

      test('converts empty title to empty string', () {
        final todo = TodoFactory.create(title: '   ');

        expect(todo.title, equals(''));
      });

      test('handles null description', () {
        final todo = TodoFactory.create(title: 'Test', description: null);

        expect(todo.description, isNull);
      });

      test('handles empty description', () {
        final todo = TodoFactory.create(title: 'Test', description: '  ');

        expect(todo.description, isNull);
      });

      test('uses medium priority by default', () {
        final todo = TodoFactory.create(title: 'Test');

        expect(todo.priority, equals(TodoPriority.medium));
      });

      test('generates unique IDs for different todos', () {
        final todo1 = TodoFactory.create(title: 'First');
        final todo2 = TodoFactory.create(title: 'Second');

        expect(todo1.id, isNot(equals(todo2.id)));
      });

      test('sets createdAt to current time', () {
        final beforeCreation = DateTime.now();
        final todo = TodoFactory.create(title: 'Test');
        final afterCreation = DateTime.now();

        expect(
          todo.createdAt.isAfter(
            beforeCreation.subtract(const Duration(seconds: 1)),
          ),
          isTrue,
        );
        expect(
          todo.createdAt.isBefore(
            afterCreation.add(const Duration(seconds: 1)),
          ),
          isTrue,
        );
      });
    });

    group('update', () {
      late Todo originalTodo;

      setUp(() {
        originalTodo = TodoFactory.create(
          title: 'Original Title',
          description: 'Original Description',
          priority: TodoPriority.low,
          categoryId: 'cat-original',
        );
      });

      test('updates title', () {
        final updated = TodoFactory.update(
          original: originalTodo,
          title: 'New Title',
        );

        expect(updated.title, equals('New Title'));
        expect(updated.id, equals(originalTodo.id));
        expect(updated.description, equals(originalTodo.description));
      });

      test('updates description', () {
        final updated = TodoFactory.update(
          original: originalTodo,
          title: originalTodo.title,
          description: 'New Description',
        );

        expect(updated.description, equals('New Description'));
        expect(updated.title, equals(originalTodo.title));
      });

      test('updates priority', () {
        final updated = TodoFactory.update(
          original: originalTodo,
          title: originalTodo.title,
          priority: TodoPriority.high,
        );

        expect(updated.priority, equals(TodoPriority.high));
      });

      test('updates categoryId', () {
        final updated = TodoFactory.update(
          original: originalTodo,
          title: originalTodo.title,
          categoryId: 'cat-new',
        );

        expect(updated.categoryId, equals('cat-new'));
      });

      test('updates deadline', () {
        final newDeadline = DateTime.now().add(const Duration(days: 5));
        final updated = TodoFactory.update(
          original: originalTodo,
          title: originalTodo.title,
          deadline: newDeadline,
        );

        expect(updated.deadline, equals(newDeadline));
      });

      test('trims whitespace when updating title', () {
        final updated = TodoFactory.update(
          original: originalTodo,
          title: '  Trimmed  ',
        );

        expect(updated.title, equals('Trimmed'));
      });

      test('trims whitespace when updating description', () {
        final updated = TodoFactory.update(
          original: originalTodo,
          title: originalTodo.title,
          description: '  Trimmed  ',
        );

        expect(updated.description, equals('Trimmed'));
      });

      test('updates multiple fields at once', () {
        final newDeadline = DateTime.now().add(const Duration(days: 3));
        final updated = TodoFactory.update(
          original: originalTodo,
          title: 'Multi Update',
          priority: TodoPriority.high,
          deadline: newDeadline,
        );

        expect(updated.title, equals('Multi Update'));
        expect(updated.priority, equals(TodoPriority.high));
        expect(updated.deadline, equals(newDeadline));
        expect(updated.description, equals(originalTodo.description));
      });
    });
  });
}
