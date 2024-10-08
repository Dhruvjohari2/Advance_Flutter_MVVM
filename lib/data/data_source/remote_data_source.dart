import 'package:advance_mvvm/data/network/app_api.dart';
import 'package:advance_mvvm/data/request/request.dart';
import 'package:advance_mvvm/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgetPasswordResponse> forgotPassword(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHome();
  Future<StoreDetailResponse> getStoreDetail();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.email, loginRequest.password, "", "");
  }

  @override
  Future<ForgetPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgetPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      registerRequest.countryMobileCode,
      registerRequest.userName,
      registerRequest.email,
      registerRequest.password,
      registerRequest.profilePicture,
    );
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _appServiceClient.getHome();
  }

  @override
  Future<StoreDetailResponse> getStoreDetail() async {
    return await _appServiceClient.getStoreDetail();
  }
}
