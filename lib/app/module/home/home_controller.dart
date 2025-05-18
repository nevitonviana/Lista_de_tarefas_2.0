import 'package:flutter/material.dart';
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
import '../../models/list_options_enum.dart';
import '../../models/notification_model.dart';
import '../../services/api/api_info_barcode_service.dart';
import '../../services/sql/sqflite_service.dart';

part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store, ControllerLifeCycle {
  final SqfliteService _serviceSQL;
  final ApiInfoBarcodeService _barcodeService;
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
    required ApiInfoBarcodeService barcodeService,
  })  : _serviceSQL = service,
        _log = log,
        _scanner = scanner,
        _storage = storage,
        _notificationService = notificationService,
        _barcodeService = barcodeService;

  @override
  Future<void> onReady() async {
    await getDaysSelectedForExpiration();
    await _showNotificationForExpiredAndForDowngrading();
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
        showNotification: false,
      );
      await _serviceSQL.saveItem(item);
      Messages.success("Salvo com sucesso");
    } catch (e, s) {
      _log.error("Erro ao salvar dados", e, s);
      Messages.alert("Erro ao salvar o produto $name");
    } finally {
      selectedOption = null;
      selectedDateTime = null;
      Loader.hide();
    }
  }

  @action
  Future<void> updateItem({required ItemModel item}) async {
    try {
      Loader.show();
      await _serviceSQL.updateItem(
        item.copyWith(date: selectedDateTime, options: selectedOption),
      );
    } catch (e, s) {
      _log.error("Erro ao Atualizar o item", e, s);
      Messages.alert("Erro ao salvar o item ${item.name}");
    } finally {
      Loader.hide();
      Modular.to.pop(item);
    }
  }

  @action
  Future<String> barcodeScanner() async {
    try {
      final result = await _scanner.barcodeScanner();

      if (result != '-1') {
        return 'result';
      } else {
        Messages.warning("Código de barras inválido");
        return '';
      }
    } catch (e, s) {
      _log.error("Erro ao escanear código de barras", e, s);
      Messages.alert("Erro ao escanear código de barras");
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
    } catch (e, s) {
      _log.error("Erro ao salvar os dias para vencimento", e, s);
      Messages.alert("Erro ao salvar os dias para vencimento");
    } finally {
      Loader.hide();
    }
  }

  Future<void> _showNotificationForExpiredAndForDowngrading() async {
    try {
      final result =
          await _serviceSQL.getItemOption(ListOptionsEnum.Rebaixa.name);

      final days = int.tryParse(daysSelectedForExpiration ?? '10') ?? 10;

      for (final e in result) {
        final resultCheck =
            Date.checkDate(date: e.date, daysForExpiration: days);

        if (resultCheck == 'rebaixar' && !e.showNotification) {
          _notificationService.showNotification(
            NotificationModel(
              id: e.id!,
              title: "Rebaixar de produto",
              body: e.name,
              payload: "payload",
              color: Colors.yellowAccent,
            ),
          );
          updateShowNotification(item: e);
        } else if (resultCheck == "vencido") {
          _notificationService.showNotification(
            NotificationModel(
              id: e.id!,
              title: "Produto Vencido na Loja",
              body: '\t\t ${e.name}',
              payload: "payload",
              color: const Color(0xFFF44336),
            ),
          );
        }
      }
    } catch (e, s) {
      _log.error("Erro ao mostrar as notificações dos itens", e, s);
      Messages.info("Erro ao mostrar as notificações dos itens");
    }
  }

  Future<void> updateShowNotification({required ItemModel item}) async {
    try {
      await _serviceSQL.updateItem(item.copyWith(showNotification: true));
    } catch (e, s) {
      _log.error("Erro ao atualizar o showNotification", e, s);
      Messages.info("Erro ao atualizar o showNotification");
    }
  }

  @action
  Future<String> getInfoBarcode({required String barcode}) async {
    try {
      Loader.show();
      final result = await _barcodeService.getInfoBarcode(barcode: barcode);
      return result?.name ?? '';
    } catch (e, s) {
      _log.error("Erro ao buscar informações do código de barras", e, s);
      Messages.info('Erro ao buscar informações do código de barras');
    } finally {
      Loader.hide();
    }
    return '';
  }
}
