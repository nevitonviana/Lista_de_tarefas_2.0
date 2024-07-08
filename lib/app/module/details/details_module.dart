import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_module.dart';
import 'details_controller.dart';
import 'details_page.dart';

class DetailsModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(DetailsController.new);
  }

  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) => DetailsPage(
        name: r.args.data,
      ),
    );
  }
}