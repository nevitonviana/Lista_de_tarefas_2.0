import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(HomeController.new);
  }

  @override
  List<Module> get imports => [];

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => HomePage());
  }
}
