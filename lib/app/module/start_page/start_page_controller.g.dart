// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StartPageController on StartPageControllerBase, Store {
  late final _$currentPageIndexAtom =
      Atom(name: 'StartPageControllerBase.currentPageIndex', context: context);

  @override
  int get currentPageIndex {
    _$currentPageIndexAtom.reportRead();
    return super.currentPageIndex;
  }

  @override
  set currentPageIndex(int value) {
    _$currentPageIndexAtom.reportWrite(value, super.currentPageIndex, () {
      super.currentPageIndex = value;
    });
  }

  late final _$StartPageControllerBaseActionController =
      ActionController(name: 'StartPageControllerBase', context: context);

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$StartPageControllerBaseActionController.startAction(
        name: 'StartPageControllerBase.setCurrentPageIndex');
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$StartPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPageIndex: ${currentPageIndex}
    ''';
  }
}
