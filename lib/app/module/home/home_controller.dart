import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/barcode/barcode_scanner/barcode_scanner.dart';
import '../../core/helpers/constants.dart';
import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/logger/app_logger.dart';
import '../../core/ui/widgets/loader.dart';
import '../../core/ui/widgets/messages.dart';
import '../../models/item_model.dart';
import '../../services/sql/sqflite_service.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  final SqfliteService _service;
  final AppLogger _log;
  final BarcodeScanner _scanner;
  final LocalStorage _storage;

  HomeControllerBase(
      {required SqfliteService service,
      required AppLogger log,
      required BarcodeScanner scanner,
      required LocalStorage storage})
      : _service = service,
        _log = log,
        _scanner = scanner,
        _storage = storage;

  @override
  void onInit([Map<String, dynamic>? params]) {
    getDaysSelectedForExpiration();
  }

  @observable
  DateTime? selectedDateTime;

  @observable
  String? selectedOption;

  @observable
  String? daysSelectedForExpiration;

  Future<void> saveProduct({
    required String name,
    required String barcode,
    String? quantity,
    String? description,
  }) async {
    try {
      Loader.show();
      final item = ItemModel(
        name: name,
        barcode: barcode,
        date: selectedDateTime!,
        options: selectedOption!,
        description: description,
        quantity: quantity,
        finished: false,
      );
      await _service.saveItem(item);
      selectedOption = null;
      selectedDateTime = null;
      Messages.success("Salvo com sucesso");
    } catch (e, s) {
      _log.error("Erro ao salvar dados", e, s);
      Messages.alert("erro ao salvar o $name");
    } finally {
      Loader.hide();
    }
  }

  @action
  Future<void> updateItem({required ItemModel item}) async {
    try {
      Loader.show();
      await _service.updateItem(item.copyWith(date: selectedDateTime, options: selectedOption));
      Loader.hide();
      Modular.to.pop(item);
    } catch (e, s) {
      _log.error("Erro ao Atualizar o item", e, s);
      Messages.alert("Erro ao salvar o item ${item.name}");
    }
  }

  @action
  Future<String> barcodeScanner() async {
    try {
      final result = await _scanner.barcodeScanner();
      if (result != '-1') {
        return result;
      } else {
        Messages.warning("Codigo de Barra invalido");
        return '';
      }
    } catch (e, s) {
      _log.error("Erro ao Scanner Codego de barra", e, s);
      Messages.alert("Erro ao Scanner codigo de barrar");
      return '';
    }
  }

  Future<void> getDaysSelectedForExpiration() async {
    try {
      Loader.show();
      daysSelectedForExpiration =
          await _storage.read(Constants.Days_Selected_For_Expiration);
    } catch (e, s) {
      _log.error("Erro ao buscar o dias ", e, s);
      daysSelectedForExpiration = "10";
      Messages.alert("Erro ao buscar o dias ");
    } finally {
      Loader.hide();
      print("------------");
      print(daysSelectedForExpiration);
    }
  }

  Future<void> saveDaysSelectedForExpiration({required String days}) async {
    try {
      Loader.show();
      await _storage.write(Constants.Days_Selected_For_Expiration, days);
      Loader.hide();
    } catch (e, s) {
      _log.error("Erro ao salva os dias para o vencimento", e, s);
      Messages.alert("Erro ao salva os dias para o vencimento");
    }
  }
}
