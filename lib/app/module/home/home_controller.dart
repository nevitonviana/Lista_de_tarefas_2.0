import 'dart:math';

import 'package:mobx/mobx.dart';

import '../../core/exception/failure.dart';
import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/logger/app_logger.dart';
import '../../core/widgtes/loader.dart';
import '../../core/widgtes/messages.dart';
import '../../models/item_model.dart';
import '../../services/sql/sqflite_service.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store, ControllerLifeCycle {
  final SqfliteService _service;
  final AppLogger _log;

  HomeControllerBase({required SqfliteService service, required AppLogger log})
      : _service = service,
        _log = log;

  @override
  void onInit([Map<String, dynamic>? params]) {}
  @observable
  DateTime? selectedDateTime;
  @observable
  String? selectedOption;

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
        finished: false,
      );
      await _service.saveItem(item);
      Messages.success("Salvo com sucesso");
    } catch (e, s) {
      _log.error("Erro ao salvar dados", e, s);
      Messages.alert("erro ao salvar o $name");
    } finally {
      Loader.hide();
    }
  }
}
