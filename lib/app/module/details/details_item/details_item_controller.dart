import 'package:mobx/mobx.dart';

import '../../../core/life_cycle/controller_life_cycle.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/share/flutter_share_app.dart';
import '../../../core/ui/widgets/messages.dart';
import '../../../models/item_model.dart';

part 'details_item_controller.g.dart';

class DetailsItemController = DetailsItemControllerBase with _$DetailsItemController;

abstract class DetailsItemControllerBase with Store, ControllerLifeCycle {
  final AppLogger _log;
  final FlutterShareApp _shareApp;

  DetailsItemControllerBase({required AppLogger log, required FlutterShareApp shareApp})
      : _log = log,
        _shareApp = shareApp;

  @override
  void onInit([Map<String, dynamic>? params]) {}

  void shareItem({required ItemModel item}) {
    try {
      _shareApp.shareItem(item);
    } catch (e, s) {
      _log.error("Erro ao compartilhas os itens", e, s);
      Messages.warning("Erro ao compartilhas os itens");
    }
  }
}
