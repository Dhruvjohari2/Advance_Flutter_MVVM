import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {

  //data connection checker is not dart 3 computable
  InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImpl(this._internetConnectionChecker);
  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
}
