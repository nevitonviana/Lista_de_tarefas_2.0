import '../../core/exception/failure.dart';
import '../../core/logger/app_logger.dart';
import '../../core/ui/widgets/date.dart';
import '../../models/item_model.dart';
import '../../models/list_options_enum.dart';
import '../../repositories/sql/sqflite_repository.dart';
import 'sqflite_service.dart';

class SqfliteServiceImpl implements SqfliteService {
  final SqfliteRepository _repository;
  final AppLogger _log;

  SqfliteServiceImpl({required SqfliteRepository repository, required AppLogger log})
      : _repository = repository,
        _log = log;

  @override
  Future<void> saveItem(ItemModel itemModel) => _repository.saveItem(itemModel);

  @override
  Future<List<ItemModel>> getItemOption(String option) => _repository.getItemOption(option);

  @override
  Future<List<ItemModel>> getItemAndCheckValidity() async {
    try {
      List<ItemModel> resultList = [];
      final result = await getItemOption(ListOptionsEnum.Rebaixa.name);
      result.map<ItemModel>(
        (e) {
          var resultCheck = Date.checkDate(date: e.date, daysForExpiration: 10);
          if (resultCheck == 'rebaixar' && !e.finished) {
            resultList.add(e);
          } else if (resultCheck == "vencido") {
            resultList.add(e);
          }
          return e;
        },
      ).toList();

      return resultList;
    } catch (e, s) {
      _log.error("Erro ao verificar as validade dos itens", e, s);
      throw const Failure(message: "Erro ao verificar as validade dos itens");
    }
  }

  @override
  Future<List<ItemModel>> searchItemBarcodeOrName(String search) =>
      _repository.searchItemBarcodeOrName(search);

  @override
  Future<void> updateItem(ItemModel itemModel) => _repository.updateItem(itemModel);

  @override
  Future<void> deleteItem(int id) => _repository.deleteItem(id);

  @override
  Future<void> deleteItemAllOfOptions(String option) => _repository.deleteItemAllOfOptions(option);
}
