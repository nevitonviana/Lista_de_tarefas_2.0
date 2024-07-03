import 'package:lista_de_tarefas_2_0/app/services/sql/sqflite_service.dart';
import '../../models/item_model.dart';
import '../../repositories/sql/sqflite_repository.dart';

class SqfliteServiceImpl implements SqfliteService {
  final SqfliteRepository _repository;

  SqfliteServiceImpl({required SqfliteRepository repository}) : _repository = repository;

  @override
  Future<void> saveItem(ItemModel itemModel) => _repository.saveItem(itemModel);

  @override
  Future<List<ItemModel>> getItemOption(String option) => _repository.getItemOption(option);

  @override
  Future<List<ItemModel>> searchItemBarcodeOrName(String search) =>
      _repository.searchItemBarcodeOrName(search);

  @override
  Future<void> updateItem(ItemModel itemModel) => _repository.saveItem(itemModel);

  @override
  Future<void> deleteItem(int id) => _repository.deleteItem(id);

  @override
  Future<void> deleteItemAllOfOptions(String option) => _repository.deleteItemAllOfOptions(option);
}
