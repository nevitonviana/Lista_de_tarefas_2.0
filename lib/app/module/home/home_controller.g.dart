// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$selectedDateTimeAtom =
      Atom(name: 'HomeControllerBase.selectedDateTime', context: context);

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

  @override
  String toString() {
    return '''
selectedDateTime: ${selectedDateTime}
    ''';
  }
}
