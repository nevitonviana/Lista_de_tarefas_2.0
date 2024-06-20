import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setObservers([Asuka.asukaHeroController]);
    return ScreenUtilInit(builder: (_, __) {
      return MaterialApp.router(
        builder: Asuka.builder,
        title: 'lista de tarefas 2 0',
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: Modular.routerConfig,
      );
    });
  }
}
