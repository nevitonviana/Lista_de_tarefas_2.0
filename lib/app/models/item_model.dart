class ItemModel {
  final int? id;
  final String name;
  final String barcode;
  final String? description;
  final String? quantity;
  final DateTime date;
  final String options;
  final bool finished;

  final bool showNotification;

//<editor-fold desc="Data Methods">
  const ItemModel({
    this.id,
    required this.name,
    required this.barcode,
    this.description,
    this.quantity,
    required this.date,
    required this.options,
    required this.finished,
    required this.showNotification
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          barcode == other.barcode &&
          description == other.description &&
          quantity == other.quantity &&
          date == other.date &&
          options == other.options &&
          finished == other.finished &&
          showNotification == other.showNotification);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      barcode.hashCode ^
      description.hashCode ^
      quantity.hashCode ^
      date.hashCode ^
      options.hashCode ^
      finished.hashCode ^
      showNotification.hashCode;

  @override
  String toString() {
    return 'ItemModel{ id: $id, name: $name, barcode: $barcode, description: $description, quantity: $quantity, date: $date, options: $options, finished: $finished, showNotification: $showNotification }';
  }

  ItemModel copyWith({
    int? id,
    String? name,
    String? barcode,
    String? description,
    String? quantity,
    DateTime? date,
    String? options,
    bool? finished,
    bool? showNotification,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
      options: options ?? this.options,
      finished: finished ?? this.finished,
      showNotification: showNotification ?? this.showNotification,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'barcode': barcode,
      'description': description,
      'quantity': quantity,
      'date': date.toIso8601String(),
      'options': options,
      'finished': finished == true ? 1 : 0,
      'show_notification': showNotification == true ? 1 : 0,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      barcode: map['barcode'] ?? '',
      description: map['description'],
      quantity: map['quantity'],
      date: DateTime.parse(map['date']),
      options: map['options'] ?? '',
      finished: map['finished'] == 1,
      showNotification: map['show_notification'] == 1,
    );
  }

//</editor-fold>
}
