import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/logger/app_logger.dart';

import '../../core/widgets/loader.dart';
import '../../core/widgets/messages.dart';
import '../../models/item_model.dart';
import '../../services/sql/sqflite_service.dart';

part 'details_controller.g.dart';

class DetailsController = DetailsControllerBase with _$DetailsController;

abstract class DetailsControllerBase with Store, ControllerLifeCycle {
  final SqfliteService _service;
  final AppLogger _log;

  @observable
  ObservableList<ItemModel> listItems = ObservableList<ItemModel>();

  DetailsControllerBase({required SqfliteService service, required AppLogger log})
      : _service = service,
        _log = log;

  @override
  Future<void> onInit([Map<String, dynamic>? params]) async {
    await getItems(params?['name'] ?? '');
  }

  @action
  Future<void> getItems(String name) async {
    try {
      // Loader.show();
      final result = await _service.getItemOption(name);
      print(result);
      listItems = result.asObservable();
      // Loader.hide();
    } catch (e, s) {
      _log.error("Erro ao busca os itens", e, s);
      Messages.warning("erro ao busca os itens");
    }
  }

  @action
  Future<void> deleteItem({required int id}) async {
    try {
      Loader.show();
      await _service.deleteItem(id);
      listItems.removeWhere((item) => item.id == id);
      Loader.hide();
    } catch (e, s) {
      // MobXException("asasas");
      _log.error("erro ao deleta o item", e, s);
      Messages.alert("Erro ao deleta o item");
    }
  }
}
