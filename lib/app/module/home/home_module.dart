import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_module.dart';
import '../../core/database/sqlite_connection_factory.dart';
import '../../core/logger/app_logger.dart';
import '../../core/logger/logger_app_logger_impl.dart';
import '../../repositories/sql/sqflite_repository.dart';
import '../../repositories/sql/sqflite_repository_impl.dart';
import '../../services/sql/sqflite_service.dart';
import '../../services/sql/sqflite_service_impl.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AppLogger>(LoggerAppLoggerImpl.new);
    i.addLazySingleton(SqliteConnectionFactory.new);
    i.addLazySingleton<SqfliteRepository>(SqfliteRepositoryImpl.new);
    i.addLazySingleton<SqfliteService>(SqfliteServiceImpl.new);
    i.addLazySingleton(HomeController.new);
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => HomePage());
  }
}
