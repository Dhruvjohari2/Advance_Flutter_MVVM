import 'package:advance_mvvm/data/data_source/remote_data_source.dart';
import 'package:advance_mvvm/data/mapper/mapper.dart';
import 'package:advance_mvvm/data/network/error_handler.dart';
import 'package:advance_mvvm/data/network/failure.dart';
import 'package:advance_mvvm/data/network/network_info.dart';
import 'package:advance_mvvm/data/request/request.dart';
import 'package:advance_mvvm/domain/model/model.dart';
import 'package:advance_mvvm/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE, response.message ?? "Error from APi side"));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
