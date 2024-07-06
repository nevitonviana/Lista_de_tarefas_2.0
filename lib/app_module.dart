import 'package:flutter_modular/flutter_modular.dart';

import 'app/module/Start_page/start_page_module.dart';
import 'app/module/details/details_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(r) {
    // r.module("/", module: StartPageModule());
    r.module("/", module: DetailsModule());
  }
}
