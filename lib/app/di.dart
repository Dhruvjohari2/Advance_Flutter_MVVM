import 'package:advance_mvvm/app/app_prefs.dart';
import 'package:advance_mvvm/data/data_source/remote_data_source.dart';
import 'package:advance_mvvm/data/network/app_api.dart';
import 'package:advance_mvvm/data/network/dio_factory.dart';
import 'package:advance_mvvm/data/network/network_info.dart';
import 'package:advance_mvvm/data/repository/repository_impl.dart';
import 'package:advance_mvvm/domain/repository/repository.dart';
import 'package:advance_mvvm/domain/usecase/login_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/login/login_viewmodel.dart';

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

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
