import 'dart:async';

import 'package:advance_mvvm/presentation/base/baseviewmodel.dart';
import 'package:advance_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:advance_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advance_mvvm/domain/usecase/login_usecase.dart';
import 'package:advance_mvvm/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel implements LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();

  StreamController isUserLoggedInSuccessfullyStreamController = StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _isAllInputsValidStreamController.close();
    _passwordStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputValid => _isAllInputsValidStreamController.stream.map((_) => _isAllInputValid());

  _validate() {
    inputIsAllInputValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputValid() {
    return _isPasswordValid(loginObject.password) && _isUserNameValid(loginObject.userName);
  }

  @override
  login() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(LoginUseCaseInput(loginObject.userName, loginObject.password))).fold(
      (failure) => {inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message)), print("failure")},
      (data) => {inputState.add(ContentState()),
        isUserLoggedInSuccessfullyStreamController.add(true),
        print("data ${data.customer?.name}")},
    );
  }
}

abstract class LoginViewModelInput {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputValid;
}
