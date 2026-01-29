import 'package:flutter/material.dart';

class DateTimeUtils {
  static Future<DateTime?> pickDateTime(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return null;

    if (!context.mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        initialDate ?? now.add(const Duration(hours: 1)),
      ),
    );

    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
