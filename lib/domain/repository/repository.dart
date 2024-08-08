import 'package:advance_mvvm/data/network/failure.dart';
import 'package:advance_mvvm/data/request/request.dart';
import 'package:advance_mvvm/domain/model/model.dart';
import 'package:dartz/dartz.dart';

abstract  class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure,String>> forgetPassword(String email);
  Future<Either<Failure,String>> register(RegisterRequest registerRequest);
}