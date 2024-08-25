import 'package:advance_mvvm/app/app_prefs.dart';
import 'package:advance_mvvm/data/data_source/local_data_source.dart';
import 'package:advance_mvvm/data/data_source/remote_data_source.dart';
import 'package:advance_mvvm/data/network/app_api.dart';
import 'package:advance_mvvm/data/network/dio_factory.dart';
import 'package:advance_mvvm/data/network/network_info.dart';
import 'package:advance_mvvm/data/repository/repository_impl.dart';
import 'package:advance_mvvm/domain/repository/repository.dart';
import 'package:advance_mvvm/domain/usecase/forget_password_usecase.dart';
import 'package:advance_mvvm/domain/usecase/home_usecase.dart';
import 'package:advance_mvvm/domain/usecase/login_usecase.dart';
import 'package:advance_mvvm/domain/usecase/register_usecase.dart';
import 'package:advance_mvvm/presentation/forget_password/forget_password_viewmodel.dart';
import 'package:advance_mvvm/presentation/login/login_viewmodel.dart';
import 'package:advance_mvvm/presentation/main/homePage/home_viewmodel.dart';
import 'package:advance_mvvm/presentation/register/register_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final SharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => SharedPrefs);

  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  instance.registerLazySingleton<Diofactory>(() => Diofactory(instance()));

  final dio = await instance<Diofactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplementer(instance()));

  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImplementer());

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(),instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(() => ForgetPasswordViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}
