import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/entities/todo_priority.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';

class WatchTodosUseCase {
  WatchTodosUseCase(this.repository);
  final TodoRepository repository;

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
