import 'package:flutter_modular/flutter_modular.dart';

import 'app/module/home/home_module.dart';
import 'app/repositories/sql/sqflite_repository.dart';
import 'app/repositories/sql/sqflite_repository_impl.dart';
import 'app/services/sql/sqflite_service.dart';
import 'app/services/sql/sqflite_service_impl.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void exportedBinds(Injector i) {

  }

  @override
  void routes(r) {
    r.module("/", module: HomeModule());
  }
}
