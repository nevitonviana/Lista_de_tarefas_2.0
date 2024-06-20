import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var connection = Modular.get<SqliteConnectionFactory>();
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        connection.closeConnection();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
