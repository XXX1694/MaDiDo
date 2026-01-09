import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do/core/services/notification_service.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;
  final NotificationService notificationService;

  DeleteTodoUseCase(this.repository, this.notificationService);

  Future<void> call(String id) async {
    await notificationService.cancelNotification(id.hashCode);
    await repository.deleteTodo(id);
  }
}
