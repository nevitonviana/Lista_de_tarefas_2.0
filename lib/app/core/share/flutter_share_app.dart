
import '../../models/item_model.dart';

abstract class FlutterShareApp {
  void shareItem(ItemModel item);

  shareListItem(List<ItemModel> markedForSharing ) {}
}
