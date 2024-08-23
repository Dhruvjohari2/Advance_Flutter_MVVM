import 'dart:async';

import 'package:advance_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  // shared variables and functions that will be used through any view model.
  final StreamController _inputStateStreamController =
  BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStateStreamController.sink;
  
  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState)=>flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }

  @override
  void start(){
    inputState.add(ContentState());
  }
}

abstract class BaseViewModelInputs {
  void start(); // will be called init. of view-model
  void dispose(); // will be called when view-model dies.

  Sink get inputState;
}

mixin class BaseViewModelOutputs {
  Stream<FlowState> get outputState {
    throw UnimplementedError();
  }
}
