import '../../core/logger/app_logger.dart';
import '../../models/item_model.dart';
import '../../repositories/sql/sqflite_repository.dart';
import 'sqflite_service.dart';

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
  Future<void> updateItem(ItemModel itemModel) => _repository.updateItem(itemModel);

  @override
  Future<void> deleteItem(int id) => _repository.deleteItem(id);

  @override
  Future<void> deleteItemAllOfOptions(String option) => _repository.deleteItemAllOfOptions(option);

  @override
  Future<ItemModel?> findByBarcode(String barcode) => _repository.findByBarcode(barcode);
}
