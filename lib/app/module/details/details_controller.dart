import 'package:mobx/mobx.dart';

import '../../core/helpers/constants.dart';
import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/logger/app_logger.dart';

import '../../core/ui/widgets/loader.dart';
import '../../core/ui/widgets/messages.dart';
import '../../models/item_model.dart';
import '../../services/sql/sqflite_service.dart';

part 'details_controller.g.dart';

class DetailsController = DetailsControllerBase with _$DetailsController;

abstract class DetailsControllerBase with Store, ControllerLifeCycle {
  final SqfliteService _service;
  final AppLogger _log;
  final LocalStorage _storage;

  DetailsControllerBase(
      {required SqfliteService service,
      required AppLogger log,
      required LocalStorage storage})
      : _service = service,
        _log = log,
        _storage = storage;

  @override
  Future<void> onInit([Map<String, dynamic>? params]) async {
    if (params?['name'] != null) {
      await getItems(params?['name']);
    } else {
      searchItemNameOrBarcode(search: params?['searchItem'] ?? '');
    }
  }

  @override
  void onReady() {
    super.onReady();
    getDaysSelectedForExpiration();
  }

  @observable
  ObservableList<ItemModel> listItems = ObservableList<ItemModel>();

  @observable
  late int daysSelectedForExpiration;

  @observable
  ItemModel? itemFinished;

  @action
  Future<void> getItems(String name) async {
    try {
      final result = await _service.getItemOption(name);
      listItems = result.asObservable();
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
      _log.error("erro ao deleta o item", e, s);
      Messages.alert("Erro ao deleta o item");
    }
  }

  @action
  void deleteAllItems({required String optionOfDeletes}) {
    try {
      Loader.show();
      _service.deleteItemAllOfOptions(optionOfDeletes);
      listItems.clear();
      Loader.hide();
    } catch (e, s) {
      _log.error("Erro ao deleta todos os itens ", e, s);
      Messages.alert('Erro ao deleta todos os itens de $optionOfDeletes');
    }
  }

  Future<void> searchItemNameOrBarcode({required String search}) async {
    try {
      final result = await _service.searchItemBarcodeOrName(search);
      listItems = result.asObservable();
    } catch (e, s) {
      _log.error("Erro ao buscar itens no banco de Dadods", e, s);
      Messages.alert("Erro ao Buscar dados ");
    }
  }

  @action
  Future<void> getDaysSelectedForExpiration() async {
    try {
      Loader.show();
      daysSelectedForExpiration = int.tryParse(
              await _storage.read(Constants.Days_Selected_For_Expiration) ??
                  '10') ??
          10;
    } catch (e, s) {
      _log.error("Erro ao buscar o dias ", e, s);
      Messages.alert("Erro ao buscar o dias ");
    } finally {
      Loader.hide();
    }
  }

  @action
  Future<void> updateFinished({required ItemModel item}) async {
    try {
      await _service.updateItem(item);

      final index = listItems.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        listItems[index] = item;
      }
    } catch (e, s) {
      _log.error("Erro ao atualizar indicador", e, s);
      Messages.alert("Erro ao atualizar indicador ");
    }
  }
}
