import '../../models/item_model.dart';

abstract class Sqflite {
  Future<void> createItem(ItemModel itemModel);

  Future<List<ItemModel>> getItemOption(String option);

  Future<List<ItemModel>> searchItemBarcodeOrName(String search);

  Future<void> updateItem(ItemModel itemModel);

  Future<void> deleteItem(int id);

  Future<void> deleteItemAllOfOptions(String option);
}
