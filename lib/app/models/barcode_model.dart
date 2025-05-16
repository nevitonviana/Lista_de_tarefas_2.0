class BarcodeModel {
  final String name;
  final String barcode;
  final String? thumbnail;

  const BarcodeModel({
    required this.name,
    required this.barcode,
    this.thumbnail,
  });

  BarcodeModel copyWith({
    String? name,
    String? barcode,
    String? thumbnail,

  }) {
    return BarcodeModel(
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'barcode': barcode,
      'thumbnail': thumbnail,
    };
  }

  factory BarcodeModel.fromMap(Map<String, dynamic> map) {
    return BarcodeModel(
      name: map['description'] ?? '',
      barcode: map['gtin']?.toString() ?? '',
      thumbnail: map['thumbnail']?.toString(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is BarcodeModel &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              barcode == other.barcode &&
              thumbnail == other.thumbnail);

  @override
  int get hashCode =>
      name.hashCode ^ barcode.hashCode ^ thumbnail.hashCode;
}
