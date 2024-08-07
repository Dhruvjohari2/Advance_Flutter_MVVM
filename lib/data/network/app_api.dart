import 'package:advance_mvvm/app/constant.dart';
import 'package:advance_mvvm/data/responses/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("lemi") String lemi,
    @Field("device-type") String deviceType,
  );

  @POST("/customers/forgetPassword")
  Future<ForgetPasswordResponse> forgetPassword(@Field("email") String email);
}
