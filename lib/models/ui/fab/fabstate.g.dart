// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fabstate.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FabState on FabStateBase, Store {
  final _$showFabAtom = Atom(name: 'FabStateBase.showFab');

  @override
  bool get showFab {
    _$showFabAtom.context.enforceReadPolicy(_$showFabAtom);
    _$showFabAtom.reportObserved();
    return super.showFab;
  }

  @override
  set showFab(bool value) {
    _$showFabAtom.context.conditionallyRunInAction(() {
      super.showFab = value;
      _$showFabAtom.reportChanged();
    }, _$showFabAtom, name: '${_$showFabAtom.name}_set');
  }

  final _$FabStateBaseActionController = ActionController(name: 'FabStateBase');

  @override
  void initFab() {
    final _$actionInfo = _$FabStateBaseActionController.startAction();
    try {
      return super.initFab();
    } finally {
      _$FabStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFab(bool value) {
    final _$actionInfo = _$FabStateBaseActionController.startAction();
    try {
      return super.setFab(value);
    } finally {
      _$FabStateBaseActionController.endAction(_$actionInfo);
    }
  }
}
