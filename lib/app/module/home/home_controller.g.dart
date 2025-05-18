// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$selectedDateTimeAtom =
      Atom(name: '_HomeControllerBase.selectedDateTime', context: context);

  @override
  DateTime? get selectedDateTime {
    _$selectedDateTimeAtom.reportRead();
    return super.selectedDateTime;
  }

  @override
  set selectedDateTime(DateTime? value) {
    _$selectedDateTimeAtom.reportWrite(value, super.selectedDateTime, () {
      super.selectedDateTime = value;
    });
  }

  late final _$selectedOptionAtom =
      Atom(name: '_HomeControllerBase.selectedOption', context: context);

  @override
  String? get selectedOption {
    _$selectedOptionAtom.reportRead();
    return super.selectedOption;
  }

  @override
  set selectedOption(String? value) {
    _$selectedOptionAtom.reportWrite(value, super.selectedOption, () {
      super.selectedOption = value;
    });
  }

  late final _$daysSelectedForExpirationAtom = Atom(
      name: '_HomeControllerBase.daysSelectedForExpiration', context: context);

  @override
  String? get daysSelectedForExpiration {
    _$daysSelectedForExpirationAtom.reportRead();
    return super.daysSelectedForExpiration;
  }

  @override
  set daysSelectedForExpiration(String? value) {
    _$daysSelectedForExpirationAtom
        .reportWrite(value, super.daysSelectedForExpiration, () {
      super.daysSelectedForExpiration = value;
    });
  }

  late final _$updateItemAsyncAction =
      AsyncAction('_HomeControllerBase.updateItem', context: context);

  @override
  Future<void> updateItem({required ItemModel item}) {
    return _$updateItemAsyncAction.run(() => super.updateItem(item: item));
  }

  late final _$barcodeScannerAsyncAction =
      AsyncAction('_HomeControllerBase.barcodeScanner', context: context);

  @override
  Future<String> barcodeScanner() {
    return _$barcodeScannerAsyncAction.run(() => super.barcodeScanner());
  }

  late final _$getInfoBarcodeAsyncAction =
      AsyncAction('_HomeControllerBase.getInfoBarcode', context: context);

  @override
  Future<String> getInfoBarcode({required String barcode}) {
    return _$getInfoBarcodeAsyncAction
        .run(() => super.getInfoBarcode(barcode: barcode));
  }

  @override
  String toString() {
    return '''
selectedDateTime: ${selectedDateTime},
selectedOption: ${selectedOption},
daysSelectedForExpiration: ${daysSelectedForExpiration}
    ''';
  }
}
