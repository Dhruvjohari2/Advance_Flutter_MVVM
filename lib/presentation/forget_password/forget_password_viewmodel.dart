import 'dart:async';

import 'package:advance_mvvm/domain/usecase/forget_password_usecase.dart';
import 'package:advance_mvvm/presentation/base/baseviewmodel.dart';
import 'package:advance_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advance_mvvm/presentation/common/state_renderer/state_renderer.dart';

class ForgetPasswordViewModel extends BaseViewModel implements ForgetPasswordViewModelInput, ForgetPasswordViewModelOutput {
  final StreamController _emailStreamController = StreamController<void>.broadcast();
  final StreamController _isALlInputValidStreamController = StreamController<void>.broadcast();

  final ForgetPasswordUseCase _forgetPasswordUseCase;

  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  var email = "";

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgetPassword() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgetPasswordUseCase.execute(email)).fold((failure) {
      inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
    }, (authObject) {
      inputState.add(SuccessState(authObject));
    });
  }

  @override
  setEmail(String email) {
    inputState.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isALlInputValidStreamController.sink;

  @override
  void dispose() {
    _emailStreamController.close();
    _isALlInputValidStreamController.close();
  }

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputValid => _isALlInputValidStreamController.stream.map((isALlInputValid) => isAllInputValid());

  isAllInputValid() {
    return isEmailValid(email);
  }

  bool isEmailValid(String email) => email.isNotEmpty && email.contains('@');

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract class ForgetPasswordViewModelInput {
  forgetPassword();

  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgetPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
