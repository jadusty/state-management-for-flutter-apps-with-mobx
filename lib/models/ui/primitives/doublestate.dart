import 'package:mobx/mobx.dart';

part 'doublestate.g.dart';

class DoubleState = DoubleStateBase with _$DoubleState;

abstract class DoubleStateBase with Store {

  @observable
  double value = 0.0;

  @action
  setDouble(double value) {
    value = value;
  }
}