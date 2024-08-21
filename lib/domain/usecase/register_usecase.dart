import 'package:advance_mvvm/data/network/failure.dart';
import 'package:advance_mvvm/data/request/request.dart';
import 'package:advance_mvvm/domain/model/model.dart';
import 'package:advance_mvvm/domain/repository/repository.dart';
import 'package:advance_mvvm/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(input.countryMobileCode,
        input.userName, input.email, input.password, input.profilePicture,input.mobileNumber));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String mobileNumber;
  String userName;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(this.countryMobileCode, this.mobileNumber, this.userName, this.email, this.password, this.profilePicture);
}
