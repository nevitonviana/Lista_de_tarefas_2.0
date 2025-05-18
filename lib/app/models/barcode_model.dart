class BarcodeModel {
  final String name;
  final String barcode;
  final String? thumbnail;

  const BarcodeModel({
    required this.name,
    required this.barcode,
    this.thumbnail,
  });

  factory BarcodeModel.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('gtin') && map.containsKey('description')) {
      // 🔹 BlueSoft
      return BarcodeModel(
        name: map['description'] ?? '',
        barcode: map['gtin']?.toString() ?? '',
        thumbnail: map['thumbnail'] ?? '',
      );
    } else if (map.containsKey('product_name') && map.containsKey('code')) {
      // 🔸 OpenFoodFacts
      return BarcodeModel(
        name: map['product_name_pt'] ?? map['product_name'] ?? '',
        barcode: map['code']?.toString() ?? '',
        thumbnail: map['image_thumb_url'] ?? '',
      );
    } else {
      throw ArgumentError('Formato de dados desconhecido para BarcodeModel');
    }
  }
}
