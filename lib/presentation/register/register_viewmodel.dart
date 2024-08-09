import 'dart:async';
import 'dart:io';

import 'package:advance_mvvm/domain/usecase/register_usecase.dart';
import 'package:advance_mvvm/presentation/base/baseviewmodel.dart';
import 'package:advance_mvvm/presentation/common/freezed_data_classes.dart';

class RegisterViewmodel extends BaseViewModel implements RegisterViewModelInput, RegisterViewModeOutput {
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _profileStreamController = StreamController<File>.broadcast();
  final StreamController _isAllInputValidStreamController = StreamController<void>.broadcast();

  RegisterUseCase _registerUseCase;
  var registerViewObject = RegisterObject("", "", "", "","");
  RegisterViewmodel(this._registerUseCase);
  @override
  void start() {
    // TODO: implement start
    super.start();
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profileStreamController.close();
    _isAllInputValidStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profileStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUseNameValid(userName));

  @override
  Stream<String> get outputErrorUserName => outputIsUserNameValid.map((isUserNameValid) => isUserNameValid ? "" : "Invalid username");

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<String> get outputErrorEmail => outputIsEmailValid.map((isEmailValid) => isEmailValid ? "" : "Invalid email");

  @override
  Stream<bool> get outputIsMobileNumberValid => _mobileNumberStreamController.stream.map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String> get outputErrorMobileNumber => outputIsMobileNumberValid.map((isMobileNumberValid) => isMobileNumberValid ? "" : "Invalid email");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<String> get outputErrorPassword => outputIsPasswordValid.map((isPasswordValid) => isPasswordValid ? "" : "Invalid Password");

  @override
  Stream<bool> get outputIsProfilePictureValid => _profileStreamController.stream.map((file)=> file);

  @override
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  _isUseNameValid(String userName) {
    return userName.length >= 8;
  }

  _isPasswordValid(String password) {
    return password.length >= 8;
  }

  _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  @override
  setUserName(String userName) {
    
    throw UnimplementedError();
  }

  @override
  setEmail(String email) {
    // TODO: implement setEmail
    throw UnimplementedError();
  }

  @override
  setMobileNumber(String mobileNumber) {
    // TODO: implement setMobileNumber
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  setProfilePicture(File file) {
    throw UnimplementedError();
  }
}

abstract class RegisterViewModelInput {
  register();
  setUserName(String userName);
  setEmail(String email);
  setMobileNumber(String mobileNumber);
  setPassword(String password);
  setProfilePicture(File file);
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
}

abstract class RegisterViewModeOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String> get outputErrorPassword;

  Stream<bool> get outputIsProfilePictureValid;
}
