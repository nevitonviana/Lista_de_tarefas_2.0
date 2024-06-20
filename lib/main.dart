import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/core/application_config.dart';
import 'app_module.dart';
import 'app_widget.dart';

Future<void> main() async {
  await ApplicationConfig().configureApp();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
