import 'package:mobx/mobx.dart';

part 'fabstate.g.dart';

class FabState = FabStateBase with _$FabState;

abstract class FabStateBase with Store {

  @observable
  bool showFab;

  @action
  void initFab() {
    showFab = true;
  }

  @action
  setFab(bool value) {
    showFab = value;
  }
}