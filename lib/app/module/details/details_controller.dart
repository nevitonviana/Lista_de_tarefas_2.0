import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/logger/app_logger.dart';
import '../../core/widgtes/messages.dart';
import '../../models/item_model.dart';
import '../../services/sql/sqflite_service.dart';

part 'details_controller.g.dart';

class DetailsController = DetailsControllerBase with _$DetailsController;

abstract class DetailsControllerBase with Store, ControllerLifeCycle {
  final SqfliteService _service;
  final AppLogger _log;

  @readonly
  List _listItems = <ItemModel>[];

  DetailsControllerBase({required SqfliteService service, required AppLogger log})
      : _service = service,
        _log = log;

  @override
  Future<void> onInit([Map<String, dynamic>? params]) async {
    await getItems(params?['name'] ?? '');
  }

  Future<void> getItems(String name) async {
    try {
      // Loader.show();
      final result = await _service.getItemOption(name);
      _listItems = result;
      // Loader.hide();
    } catch (e, s) {
      _log.error("Erro ao busca os itens", e, s);
      Messages.warning("erro ao busca os itens");
    }
  }
}
