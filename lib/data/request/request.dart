class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest(this.email, this.password, this.deviceType, this.imei);
}

class RegisterRequest {
  String countryMobileCode;
  String userName;
  String email;
  String mobileNumber;
  String password;
  String profilePicture;

  RegisterRequest(this.countryMobileCode,this.userName, this.email,this.mobileNumber,this.password,this.profilePicture);
}
