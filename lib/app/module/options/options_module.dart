import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'options_controller.dart';
import 'options_page.dart';

class OptionsModule extends Module {

    @override
    void binds(i) {
        i.addLazySingleton(OptionsController.new);
    }

    @override
    List<Module> get imports => [];

    @override
    void routes(r) {
       r.child(Modular.initialRoute, child: (context) => const OptionsPage());
    }
    
 }