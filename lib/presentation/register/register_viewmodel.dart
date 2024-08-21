import 'dart:async';
import 'dart:io';

import 'package:advance_mvvm/domain/usecase/register_usecase.dart';
import 'package:advance_mvvm/presentation/base/baseviewmodel.dart';
import 'package:advance_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:advance_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advance_mvvm/presentation/common/state_renderer/state_renderer.dart';

class RegisterViewModel extends BaseViewModel implements RegisterViewModelInput, RegisterViewModeOutput {
  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _profileStreamController = StreamController<File>.broadcast();
  final StreamController _isAllInputValidStreamController = StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController = StreamController<bool>();

  final RegisterUseCase _registerUseCase;
  var registerViewObject = RegisterObject("", "", "", "", "", "");
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
    super.start();
  }

  @override
  register() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(RegisterUseCaseInput(registerViewObject.userName, registerViewObject.password,
            registerViewObject.countryMobileCode, registerViewObject.mobileNumber, registerViewObject.profilePicture, registerViewObject.email)))
        .fold(
      (failure) => {inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message)), print("failure"),
        isUserLoggedInSuccessfullyStreamController.add(true),
      },
      (data) => {
        inputState.add(ContentState()),
        _isAllInputValidStreamController.add(true),
        isUserLoggedInSuccessfullyStreamController.add(true),
        print("data ${data.customer?.name}")
      },
    );
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profileStreamController.close();
    _isAllInputValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUseNameValid(userName)) {
      registerViewObject = registerViewObject.copyWith(userName: userName);
    } else {
      registerViewObject = registerViewObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (_isEmailValid(email)) {
      registerViewObject = registerViewObject.copyWith(email: email);
    } else {
      registerViewObject = registerViewObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registerViewObject = registerViewObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerViewObject = registerViewObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerViewObject = registerViewObject.copyWith(password: password);
    } else {
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputProfilePicture.add(file);
    if (file.path.isNotEmpty) {
      registerViewObject = registerViewObject.copyWith(profilePicture: file.path);
    } else {
      registerViewObject = registerViewObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  setMobileCode(String mobileCode) {
    if (mobileCode.isNotEmpty) {
      registerViewObject = registerViewObject.copyWith(countryMobileCode: mobileCode);
    } else {
      registerViewObject = registerViewObject.copyWith(countryMobileCode: "");
    }
    _validate();
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
  Sink get inputAllInputsValid => _isAllInputValidStreamController.sink;

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
  Stream<String> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) => isMobileNumberValid ? "" : "Invalid Mobile Number");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<String> get outputErrorPassword => outputIsPasswordValid.map((isPasswordValid) => isPasswordValid ? "" : "Invalid Password");

  @override
  Stream<File> get outputProfilePicture => _profileStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsAllInputsValid => _isAllInputValidStreamController.stream.map((_) => _validateAllInputs());

  _isUseNameValid(String userName) {
    return userName.length >= 5;
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

  _validateAllInputs() {
    return registerViewObject.profilePicture.isNotEmpty &&
        registerViewObject.email.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.mobileNumber.isNotEmpty &&
        registerViewObject.userName.isNotEmpty &&
        registerViewObject.countryMobileCode.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInput {
  register();
  setUserName(String userName);
  setEmail(String email);
  setMobileNumber(String mobileNumber);
  setPassword(String password);
  setProfilePicture(File file);
  setMobileCode(String countryCode);
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllInputsValid;
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

  Stream<File> get outputProfilePicture;
  Stream<bool> get outputIsAllInputsValid;
}
