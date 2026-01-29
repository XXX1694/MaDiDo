import 'package:to_do/core/services/notification_service.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodoUseCase {
  UpdateTodoUseCase(this.repository, this.notificationService);
  final TodoRepository repository;
  final NotificationService notificationService;

  Future<void> call(Todo todo) async {
    await repository.updateTodo(todo);

    // Cancel existing notification just in case (or to update it)
    await notificationService.cancelNotification(todo.id.hashCode);

    if (!todo.isCompleted && todo.deadline != null) {
      if (todo.deadline!.isAfter(DateTime.now())) {
        await notificationService.scheduleNotification(
          id: todo.id.hashCode,
          title: 'Todo Reminder',
          body: todo.title,
          scheduledDate: todo.deadline!,
        );
      }
    }
  }
}
