import 'dart:async';

import 'package:advance_mvvm/domain/usecase/login_usecase.dart';
import 'package:advance_mvvm/presentation/base/baseviewmodel.dart';
import 'package:advance_mvvm/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel implements LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController = StreamController<String>.broadcast();
  StreamController _passwordStreamController = StreamController<String>.broadcast();
  var loginObject = LoginObject("", "");

  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
  }

  @override
  login() async {
    (await _loginUseCase.execute(LoginUseCaseInput(loginObject.userName, loginObject.password))).fold(
      (failure) => {print(failure.message)},
      (data) => {print(data.customer?.name)},
    );
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;
}
