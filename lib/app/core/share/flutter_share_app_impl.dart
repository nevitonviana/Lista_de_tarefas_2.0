import 'package:share_plus/share_plus.dart';

import '../../models/item_model.dart';
import '../exception/failure.dart';
import '../logger/app_logger.dart';
import '../ui/widgets/date.dart';
import 'flutter_share_app.dart';

class FlutterShareAppImpl implements FlutterShareApp {
  final AppLogger _log;

  FlutterShareAppImpl({required AppLogger log}) : _log = log;

  @override
  void shareItem(ItemModel item) {
    try {
      final description =
          item.description!.isNotEmpty ? item.description : 'Sem Descrição';
      SharePlus.instance.share(
        ShareParams(
          //o Texto a baixo nao pode ser alinha, pq o whatsapp nao aceita
          text: '''
         - Nome:\t${item.name}\n- Codigo:\t${item.barcode}\n- Info:\t *${item.options}*
- Data:\t*${Date.format(item.date)}*\n- Quantidade: \t ${item.quantity} UN/Kg\n- Descrição: \t $description'''
              .trim(),
        ),
      );
    } catch (e, s) {
      _log.error("Erro ao compartilhas os itens", e, s);
      const Failure(message: "Erro ao compartilhas os itens");
    }
  }
}
