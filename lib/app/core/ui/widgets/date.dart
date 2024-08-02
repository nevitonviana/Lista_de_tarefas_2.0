import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date {
  Date._();

  static format(DateTime date) {
    final format = DateFormat('dd/MM/y');
    try {
      return format.format(date);
    } catch (e) {
      return "";
    }
  }

  static indicatorByColor({required DateTime date, required int daysForExpiration}) {
    if (date.toIso8601String().isNotEmpty) {
      final dataDifference = DateTime.now().add(const Duration(days: -1)).difference(date).inDays;
      if (dataDifference >= 0) {
        return Colors.red.shade200;
      } else if (dataDifference >= -daysForExpiration) {
        return Colors.yellow.shade200;
      }
    } else {
      return Colors.white70;
    }
  }

  static checkDate({required DateTime date, required int daysForExpiration}) {
    if (date.toIso8601String().isNotEmpty) {
      final dataDifference = DateTime.now().add(const Duration(days: -1)).difference(date).inDays;
      if (dataDifference >= 0) {
        return 'vencido';
      } else if (dataDifference >= -daysForExpiration) {
        return 'rebaixar';
      }
    }
  }
}
