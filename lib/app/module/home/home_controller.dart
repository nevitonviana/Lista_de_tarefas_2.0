import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/logger/app_logger.dart';

import '../../core/widgets/loader.dart';
import '../../core/widgets/messages.dart';
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
      // Modular.to.pop();
    } catch (e, s) {
      _log.error("Erro ao Atualizar o item", e, s);
      Messages.alert("Erro ao salvar o item ${item.name}");
    }
  }
}
