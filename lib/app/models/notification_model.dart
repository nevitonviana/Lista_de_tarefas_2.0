import 'dart:ui';

class NotificationModel {
  final int id;
  final String title;
  final String body;
  final String payload;

  final Color color;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.color,
  });
}
