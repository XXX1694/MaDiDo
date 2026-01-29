import 'package:to_do/features/todo/domain/entities/sort_option.dart';
import 'package:to_do/features/todo/domain/entities/todo.dart';

class TodoSorter {
  static List<Todo> sort(List<Todo> todos, SortOption sortOption) {
    return List<Todo>.from(todos)..sort((a, b) {
      // 1. Pinned always on top
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;

      switch (sortOption) {
        case SortOption.createdAt:
          return b.createdAt.compareTo(a.createdAt);
        case SortOption.deadline:
          if (a.deadline == null && b.deadline == null) return 0;
          if (a.deadline == null) return 1;
          if (b.deadline == null) return -1;
          return a.deadline!.compareTo(b.deadline!);
        case SortOption.alphabetical:
          return a.title.toLowerCase().compareTo(b.title.toLowerCase());
        case SortOption.priority:
          if (a.priority.index > b.priority.index) return -1;
          if (a.priority.index < b.priority.index) return 1;
          return b.createdAt.compareTo(a.createdAt); // Secondary
      }
    });
  }
}
