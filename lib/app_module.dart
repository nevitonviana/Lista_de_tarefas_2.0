import 'package:flutter_modular/flutter_modular.dart';

import 'app/barcode/barcode_scanner/barcode_scanner.dart';
import 'app/barcode/barcode_scanner/barcode_scanner_impl.dart';
import 'app/core/database/sqlite_connection_factory.dart';
import 'app/core/logger/app_logger.dart';
import 'app/core/logger/logger_app_logger_impl.dart';
import 'app/core/shara/flutter_share_app.dart';
import 'app/core/shara/flutter_share_app_impl.dart';
import 'app/module/Start_page/start_page_module.dart';
import 'app/repositories/sql/sqflite_repository.dart';
import 'app/repositories/sql/sqflite_repository_impl.dart';
import 'app/services/sql/sqflite_service.dart';
import 'app/services/sql/sqflite_service_impl.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<AppLogger>(LoggerAppLoggerImpl.new);
    i.addLazySingleton(SqliteConnectionFactory.new);
    i.addLazySingleton<SqfliteRepository>(SqfliteRepositoryImpl.new);
    i.addLazySingleton<SqfliteService>(SqfliteServiceImpl.new);
    i.addLazySingleton<BarcodeScanner>(BarcodeScannerImpl.new);
    i.addLazySingleton<FlutterShareApp>(FlutterShareAppImpl.new);
  }

  @override
  void routes(r) {
    r.module("/", module: StartPageModule());
    // r.module("/", module: DetailsModule());
  }
}
