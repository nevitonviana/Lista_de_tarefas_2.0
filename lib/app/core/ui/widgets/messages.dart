
import 'package:asuka/asuka.dart';

class Messages {
  Messages._();

  static void alert(String message) {
    AsukaMaterialBanner.alert(message).show();
  }

  static void success(String message) {
    AsukaMaterialBanner.success(message).show();
  }

  static void warning(String message) {
    AsukaMaterialBanner.warning(message).show();
  }

  static void info(String message) {
    AsukaSnackbar.info(message).show();
  }
}
