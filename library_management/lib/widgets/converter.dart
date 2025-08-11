import 'package:flutter/material.dart';

String convertDate(String dateTimeStr) {
  final dateTimeUtc = DateTime.parse(dateTimeStr);
  final localDateTime = dateTimeUtc.toLocal();

  final monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final month = monthNames[localDateTime.month - 1];
  final day = localDateTime.day;
  final year = localDateTime.year;

  return '$month $day, $year';
}

String convertTimeOnly(String dateTimeStr) {
  final dateTimeUtc = DateTime.parse(dateTimeStr);
  final localDateTime = dateTimeUtc.toLocal();

  int hour = localDateTime.hour;
  final minute = localDateTime.minute.toString().padLeft(2, '0');
  final period = hour >= 12 ? 'PM' : 'AM';

  if (hour == 0) {
    hour = 12;
  } else if (hour > 12) {
    hour -= 12;
  }

  return '$hour:$minute $period';
}

String convertDateTimePH(String isoString) {
  final dateTime = DateTime.parse(isoString).toLocal();

  final date = convertDate(dateTime.toIso8601String());
  final time = convertTimeOnly(dateTime.toIso8601String());

  return '$date at $time';
}

String convertDurationToDueString(DateTime dateOverdue) {
  final now = DateTime.now();
  final difference = dateOverdue.difference(now);

  // If overdue already
  if (difference.isNegative) return 'Overdue';

  final days = difference.inDays;
  final hours = difference.inHours % 24;

  final dayPart = days > 0 ? '$days day${days == 1 ? '' : 's'}' : '';
  final hourPart = hours > 0 ? '$hours hr${hours == 1 ? '' : 's'}' : '';

  if (dayPart.isNotEmpty && hourPart.isNotEmpty) {
    return '$dayPart and $hourPart';
  } else if (dayPart.isNotEmpty) {
    return dayPart;
  } else if (hourPart.isNotEmpty) {
    return hourPart;
  } else {
    return 'Less than an hour';
  }
}

String getDueInLabel(DateTime dueDate, DateTime? returnDate) {
  if (returnDate != null) {
    if (returnDate.isAfter(dueDate)) {
      final lateDuration = returnDate.difference(dueDate);
      final days = lateDuration.inDays;
      final hours = lateDuration.inHours % 24;
      final minutes = lateDuration.inMinutes % 60;

      if (days == 0 && hours == 0) {
        return 'Returned late by $minutes min';
      } else if (days == 0) {
        return 'Returned late by $hours hr${hours != 1 ? 's' : ''} and $minutes min';
      } else {
        return 'Returned late by $days day${days != 1 ? 's' : ''} and $hours hr${hours != 1 ? 's' : ''}';
      }
    } else {
      return 'Returned on time';
    }
  } else {
    final now = DateTime.now();
    final difference = dueDate.difference(now);

    if (difference.isNegative) return 'Overdue';

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    if (days == 0 && hours == 0) {
      return '$minutes min remaining';
    } else if (days == 0) {
      return '$hours hr${hours != 1 ? 's' : ''} and $minutes min remaining';
    } else {
      return '$days day${days != 1 ? 's' : ''} and $hours hr${hours != 1 ? 's' : ''} remaining';
    }
  }
}

Color getReturnStatusColor(
  DateTime dueDate,
  DateTime? returnDate,
  BuildContext context,
) {
  final now = DateTime.now();

  if (returnDate != null) {
    if (returnDate.isAfter(dueDate)) {
      return Colors.orangeAccent.withAlpha(150); // ❌ Returned late
    } else {
      return Colors.green.withAlpha(150); // ✅ Returned on time
    }
  } else {
    if (dueDate.isBefore(now)) {
      return Colors.red.withAlpha(150); // ❌ Overdue and not returned
    } else {
      return Theme.of(context).textTheme.titleSmall!.color!; // ⏳ Still on time
    }
  }
}
