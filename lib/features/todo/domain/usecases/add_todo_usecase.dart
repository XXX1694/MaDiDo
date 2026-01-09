import 'package:to_do/features/todo/domain/entities/todo.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do/core/services/notification_service.dart';

class AddTodoUseCase {
  final TodoRepository repository;
  final NotificationService notificationService;

  AddTodoUseCase(this.repository, this.notificationService);

  Future<void> call(Todo todo) async {
    await repository.addTodo(todo);

    if (todo.deadline != null) {
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
