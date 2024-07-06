import 'package:flutter_modular/flutter_modular.dart';

import '../details/details_module.dart';
import '../home/home_module.dart';
import '../home/home_page.dart';
import 'start_page_controller.dart';
import 'start_page.dart';

class StartPageModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(StartPageController.new);
  }

  @override
  List<Module> get imports => [HomeModule()];

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const StartHomePage(),
    );
    r.module("/home", module: HomeModule());
    r.module("/details", module: DetailsModule());
  }
}
