import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do/core/services/notification_service.dart';

class DeleteTodoUseCase {
  DeleteTodoUseCase(this.repository, this.notificationService);
  final TodoRepository repository;
  final NotificationService notificationService;

  Future<void> call(String id) async {
    await notificationService.cancelNotification(id.hashCode);
    await repository.deleteTodo(id);
  }
}
