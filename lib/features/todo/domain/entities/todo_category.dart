import 'package:equatable/equatable.dart';

class TodoCategory extends Equatable {
  // ARGB int

  const TodoCategory({
    required this.id,
    required this.name,
    required this.colorValue,
  });
  final String id;
  final String name;
  final int colorValue;

  @override
  List<Object?> get props => [id, name, colorValue];

  static const List<TodoCategory> defaultCategories = [
    TodoCategory(id: 'work', name: 'Work', colorValue: 0xFFE57373), // Red
    TodoCategory(
      id: 'personal',
      name: 'Personal',
      colorValue: 0xFF64B5F6,
    ), // Blue
    TodoCategory(id: 'study', name: 'Study', colorValue: 0xFF81C784), // Green
  ];
}
