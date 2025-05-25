// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailsController on DetailsControllerBase, Store {
  late final _$listItemsAtom =
      Atom(name: 'DetailsControllerBase.listItems', context: context);

  @override
  ObservableList<ItemModel> get listItems {
    _$listItemsAtom.reportRead();
    return super.listItems;
  }

  @override
  set listItems(ObservableList<ItemModel> value) {
    _$listItemsAtom.reportWrite(value, super.listItems, () {
      super.listItems = value;
    });
  }

  late final _$daysSelectedForExpirationAtom = Atom(
      name: 'DetailsControllerBase.daysSelectedForExpiration',
      context: context);

  @override
  int get daysSelectedForExpiration {
    _$daysSelectedForExpirationAtom.reportRead();
    return super.daysSelectedForExpiration;
  }

  bool _daysSelectedForExpirationIsInitialized = false;

  @override
  set daysSelectedForExpiration(int value) {
    _$daysSelectedForExpirationAtom.reportWrite(
        value,
        _daysSelectedForExpirationIsInitialized
            ? super.daysSelectedForExpiration
            : null, () {
      super.daysSelectedForExpiration = value;
      _daysSelectedForExpirationIsInitialized = true;
    });
  }

  late final _$itemFinishedAtom =
      Atom(name: 'DetailsControllerBase.itemFinished', context: context);

  @override
  ItemModel? get itemFinished {
    _$itemFinishedAtom.reportRead();
    return super.itemFinished;
  }

  @override
  set itemFinished(ItemModel? value) {
    _$itemFinishedAtom.reportWrite(value, super.itemFinished, () {
      super.itemFinished = value;
    });
  }

  late final _$listMarkedForSharingAtom = Atom(
      name: 'DetailsControllerBase.listMarkedForSharing', context: context);

  @override
  ObservableList<ItemModel> get listMarkedForSharing {
    _$listMarkedForSharingAtom.reportRead();
    return super.listMarkedForSharing;
  }

  @override
  set listMarkedForSharing(ObservableList<ItemModel> value) {
    _$listMarkedForSharingAtom.reportWrite(value, super.listMarkedForSharing,
        () {
      super.listMarkedForSharing = value;
    });
  }

  late final _$getItemsAsyncAction =
      AsyncAction('DetailsControllerBase.getItems', context: context);

  @override
  Future<void> getItems(String name) {
    return _$getItemsAsyncAction.run(() => super.getItems(name));
  }

  late final _$deleteItemAsyncAction =
      AsyncAction('DetailsControllerBase.deleteItem', context: context);

  @override
  ObservableFuture<void> deleteItem({required int id}) {
    return ObservableFuture<void>(
        _$deleteItemAsyncAction.run(() => super.deleteItem(id: id)));
  }

  late final _$deleteItemListAsyncAction =
      AsyncAction('DetailsControllerBase.deleteItemList', context: context);

  @override
  Future<void> deleteItemList() {
    return _$deleteItemListAsyncAction.run(() => super.deleteItemList());
  }

  late final _$getDaysSelectedForExpirationAsyncAction = AsyncAction(
      'DetailsControllerBase.getDaysSelectedForExpiration',
      context: context);

  @override
  Future<void> getDaysSelectedForExpiration() {
    return _$getDaysSelectedForExpirationAsyncAction
        .run(() => super.getDaysSelectedForExpiration());
  }

  late final _$updateFinishedAsyncAction =
      AsyncAction('DetailsControllerBase.updateFinished', context: context);

  @override
  Future<void> updateFinished({required ItemModel item}) {
    return _$updateFinishedAsyncAction
        .run(() => super.updateFinished(item: item));
  }

  late final _$brandToShareAsyncAction =
      AsyncAction('DetailsControllerBase.brandToShare', context: context);

  @override
  ObservableFuture<void> brandToShare({required ItemModel item}) {
    return ObservableFuture<void>(
        _$brandToShareAsyncAction.run(() => super.brandToShare(item: item)));
  }

  late final _$DetailsControllerBaseActionController =
      ActionController(name: 'DetailsControllerBase', context: context);

  @override
  void deleteAllItems({required String optionOfDeletes}) {
    final _$actionInfo = _$DetailsControllerBaseActionController.startAction(
        name: 'DetailsControllerBase.deleteAllItems');
    try {
      return super.deleteAllItems(optionOfDeletes: optionOfDeletes);
    } finally {
      _$DetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listItems: ${listItems},
daysSelectedForExpiration: ${daysSelectedForExpiration},
itemFinished: ${itemFinished},
listMarkedForSharing: ${listMarkedForSharing}
    ''';
  }
}
