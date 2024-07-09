import 'package:flutter_modular/flutter_modular.dart';

import 'details_item_controller.dart';
import 'details_item_page.dart';

class DetailsItemModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(DetailsItemController.new);
  }

  @override
  List<Module> get imports => [];

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) => DetailsItemPage(
        item: r.args.data,
      ),
    );
  }
}
