import 'package:intl/intl.dart';

String timeAgo(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inDays > 30) {
    return DateFormat('dd MMM yyyy, h:mm a').format(date);
  } else if (diff.inDays > 1) {
    return '${diff.inDays} days ago';
  } else if (diff.inHours > 1) {
    return '${diff.inHours} hours ago';
  } else if (diff.inMinutes > 1) {
    return '${diff.inMinutes} minutes ago';
  } else {
    return 'just now';
  }
}