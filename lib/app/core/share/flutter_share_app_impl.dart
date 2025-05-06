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
          text: _createShareParams(item),
        ),
      );
    } catch (e, s) {
      _log.error("Erro ao compartilhas os itens", e, s);
      const Failure(message: "Erro ao compartilhas os itens");
    }
  }

  @override
  Future<void> shareListItem(List<ItemModel> items) async {
    try {
      final listItems = items.map((e) => _createShareParams(e)).toList();

      SharePlus.instance.share(
        ShareParams(
          text: listItems.join('\n\n'),
        ),
      );
    } catch (e, s) {
      _log.error("Erro ao compartilhar os itens", e, s);
      const Failure(message: "Erro ao compartilhar os itens");
    }
  }

  String _createShareParams(ItemModel item) {
    final buffer = StringBuffer();

    final description = item.description?.isNotEmpty == true
        ? item.description
        : 'Sem descrição';

    buffer.writeln("📝 Produto: *${item.name}*");
    buffer.writeln("📦 Código: ${item.barcode}");
    buffer.writeln("📁 Categoria: ${item.options}");
    buffer.writeln("📅 Data: *${Date.format(item.date)}*");
    buffer.writeln("📊 Quantidade: ${item.quantity} UN/Kg");
    buffer.writeln("🧾 Descrição: $description");
    buffer.writeln("------------------------");

    return buffer.toString().trim();
  }
}
