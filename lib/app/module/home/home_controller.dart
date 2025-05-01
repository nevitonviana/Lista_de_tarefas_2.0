import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/barcode/barcode_scanner/barcode_scanner.dart';
import '../../core/helpers/constants.dart';
import '../../core/life_cycle/controller_life_cycle.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/logger/app_logger.dart';
import '../../core/notification_service/notification_service.dart';
import '../../core/ui/widgets/date.dart';
import '../../core/ui/widgets/loader.dart';
import '../../core/ui/widgets/messages.dart';
import '../../models/item_model.dart';
import '../../models/notification_model.dart';
import '../../services/sql/sqflite_service.dart';

part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store, ControllerLifeCycle {
  final SqfliteService _service;
  final AppLogger _log;
  final BarcodeScanner _scanner;

  final LocalStorage _storage;

  final NotificationService _notificationService;

  _HomeControllerBase({
    required SqfliteService service,
    required AppLogger log,
    required BarcodeScanner scanner,
    required LocalStorage storage,
    required NotificationService notificationService,
  })  : _service = service,
        _log = log,
        _scanner = scanner,
        _storage = storage,
        _notificationService = notificationService;

  @override
  void onReady() {
    getDaysSelectedForExpiration();
    _showNotificationForExpiredAndForDowngrading();
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
      await _service.updateItem(
          item.copyWith(date: selectedDateTime, options: selectedOption));
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
      daysSelectedForExpiration =
          await _storage.read<String>(Constants.Days_Selected_For_Expiration);
    } catch (e, s) {
      _log.error("Erro ao buscar o dias ", e, s);
      Messages.alert("Erro ao buscar o dias ");
    } finally {}
  }

  Future<void> saveDaysSelectedForExpiration({required String days}) async {
    try {
      Loader.show();
      await _storage.write<String>(
          Constants.Days_Selected_For_Expiration, days);
      getDaysSelectedForExpiration();
      Loader.hide();
    } catch (e, s) {
      _log.error("Erro ao salva os dias para o vencimento", e, s);
      Messages.alert("Erro ao salva os dias para o vencimento");
    }
  }

  Future<void> _showNotificationForExpiredAndForDowngrading() async {
    try {
      final result = await _service.getItemAndCheckValidity();
      result.map(
        (e) {
          var resultCheck = Date.checkDate(
              date: e.date,
              daysForExpiration:
                  int.tryParse(daysSelectedForExpiration ?? '10') ?? 10);
          if (resultCheck == 'rebaixar') {
            _notificationService.showNotification(
              NotificationModel(
                id: e.id!,
                title: "Rebaixar de produto",
                body: e.name,
                payload: "payload",
              ),
            );

          } else if (resultCheck == "vencido") {
            _notificationService.showNotification(NotificationModel(
                id: e.id!,
                title: "Produto Vencido na Loja",
                body: e.name,
                payload: "payload"));
          }
        },
      ).toList();
    } catch (e, s) {
      _log.error("Erro ao mostar as Notificações dos itens", e, s);
      Messages.info("Erro ao mostar as Notificações dos itens");
    }
  }
}
