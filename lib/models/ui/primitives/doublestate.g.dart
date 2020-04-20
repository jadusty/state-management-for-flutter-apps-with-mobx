// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doublestate.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DoubleState on DoubleStateBase, Store {
  final _$valueAtom = Atom(name: 'DoubleStateBase.value');

  @override
  double get value {
    _$valueAtom.context.enforceReadPolicy(_$valueAtom);
    _$valueAtom.reportObserved();
    return super.value;
  }

  @override
  set value(double value) {
    _$valueAtom.context.conditionallyRunInAction(() {
      super.value = value;
      _$valueAtom.reportChanged();
    }, _$valueAtom, name: '${_$valueAtom.name}_set');
  }

  final _$DoubleStateBaseActionController =
      ActionController(name: 'DoubleStateBase');

  @override
  dynamic setDouble(double value) {
    final _$actionInfo = _$DoubleStateBaseActionController.startAction();
    try {
      return super.setDouble(value);
    } finally {
      _$DoubleStateBaseActionController.endAction(_$actionInfo);
    }
  }
}
