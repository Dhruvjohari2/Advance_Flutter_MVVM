import 'package:advance_mvvm/data/data_source/local_data_source.dart';
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
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._localDataSource, this._networkInfo);

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
        print("error $error ");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      print("else");
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ResponseCode.DEFAULT, response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE, response.message ?? "Error from APi side"));
        }
      } catch (error) {
        print("error $error ");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      print("else");
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      final response = await _localDataSource.getHome();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHome();
          if (response.status == ApiInternalStatus.SUCCESS) {
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE, response.message ?? "Error from APi side"));
          }
        } catch (error) {
          print("error $error ");
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        print("else");
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
