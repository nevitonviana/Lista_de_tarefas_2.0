import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'opitons_controller.dart';
import 'opitons_page.dart';

class OpitonsModule extends Module {

    @override
    void binds(i) {
        i.addLazySingleton(OpitonsController.new);
    }

    @override
    List<Module> get imports => [];

    @override
    void routes(r) {
       r.child(Modular.initialRoute, child: (context) => const OpitonsPage());
    }
    
 }