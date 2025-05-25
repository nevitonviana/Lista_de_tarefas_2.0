import '../../models/item_model.dart';

abstract class SqfliteRepository {
  Future<void> saveItem(ItemModel itemModel);

  Future<List<ItemModel>> getItemOption(String option);

  Future<ItemModel?> findByBarcode(String barcode);

  Future<List<ItemModel>> searchItemBarcodeOrName(String search);

  Future<void> updateItem(ItemModel itemModel);

  Future<void> deleteItem(int id);

  Future<void> deleteItemAllOfOptions(String option);
}
