import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

class Loader {
  static OverlayEntry? _entry;
  static bool _open = false;

  Loader._();

  static void show() {
    _entry ??= OverlayEntry(
      builder: (_) => Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    if (!_open) {
      _open = true;
      Asuka.addOverlay(_entry!);
    }
  }

  static void hide() {
    if (_open) {
      _open = false;
      _entry?.remove();
    }
  }
}
