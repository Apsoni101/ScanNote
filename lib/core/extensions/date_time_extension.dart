
import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/extensions/localization_extension.dart';


extension FriendlyDateTimeExtension on String? {
  String toFriendlyDate() {
    if (this == null || this!.isEmpty) {
      return '';
    }

    try {
      final DateTime dateTime = DateTime.parse(this!);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(dateTime);

      if (difference.inDays == 0) {
        return 'Today';
      }

      if (difference.inDays == 1) {
        return 'Yesterday';
      }

      if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      }

      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (_) {
      return '';
    }
  }
}

extension DateTimeFormatting on DateTime {
  /// Formats DateTime as a relative timestamp (e.g., "just now", "5m ago")
  ///
  /// Returns formatted string based on time difference:
  /// - Less than 60 seconds: "just now"
  /// - Less than 60 minutes: "5m ago"
  /// - Less than 24 hours: "3h ago"
  /// - Less than 7 days: "2d ago"
  /// - Otherwise: "DD/MM/YYYY HH:mm"
  String toRelativeFormat(final BuildContext context) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return context.locale.justNow;
    } else if (difference.inMinutes < 60) {
      return context.locale.minutesAgo(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return context.locale.hoursAgo(difference.inHours);
    } else if (difference.inDays < 7) {
      return context.locale.daysAgo(difference.inDays);
    } else {
      return '$day/$month/$year $hour:${minute.toString().padLeft(2, '0')}';
    }
  }

  /// Formats DateTime in DD/MM/YYYY HH:mm format
  String toFormattedString() {
    return '$day/$month/$year $hour:${minute.toString().padLeft(2, '0')}';
  }

  /// Formats DateTime in DD/MM/YYYY format only
  String toDateString() {
    return '$day/$month/$year';
  }

  /// Formats DateTime in HH:mm format
  String toTimeString() {
    return '$hour:${minute.toString().padLeft(2, '0')}';
  }

  /// Returns true if the date is today
  bool get isToday {
    final DateTime now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Returns true if the date is yesterday
  bool get isYesterday {
    final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Returns the number of days since this date
  int get daysSince {
    final DateTime now = DateTime.now();
    return now.difference(this).inDays;
  }
}
