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
      SharePlus.instance.share(
        ShareParams(
          text: '''
         - Nome:  \t ${item.name} 
         - Codigo:\t ${item.barcode} 
         - Info:  \t ${item.options} 
         - Data:  \t *${Date.format(item.date)}* 
         - Quantidade: \t ${item.quantity}UN/Kg
         - Descrição: \t  ${item.description}  
          ''',
        ),
      );
    } catch (e, s) {
      _log.error("Erro ao compartilhas os itens", e, s);
      const Failure(message: "Erro ao compartilhas os itens");
    }
  }
}
