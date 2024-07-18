import 'package:flutter_share/flutter_share.dart';
import '../../models/item_model.dart';
import '../exception/failure.dart';
import '../logger/app_logger.dart';
import 'flutter_share_app.dart';

class FlutterShareAppImpl implements FlutterShareApp {
  final AppLogger _log;

  FlutterShareAppImpl({required AppLogger log}) : _log = log;

  @override
  void shareItem(ItemModel item) {
    try {
      FlutterShare.share(title: "Produto", text: '''
      Nome: ${item.name};
      Codigo: ${item.barcode};
      Qtd/Kg: ${item.quantity};
      Validade: ${item.date};
      Opição: ${item.options};
      ''');
    } catch (e, s) {
      _log.error("Erro ao compartilhas os itens", e, s);
      const Failure(message: "Erro ao compartilhas os itens");
    }
  }
}
