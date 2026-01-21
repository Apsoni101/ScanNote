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
