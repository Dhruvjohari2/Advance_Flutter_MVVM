import 'package:advance_mvvm/data/network/failure.dart';
import 'package:advance_mvvm/domain/model/model.dart';
import 'package:advance_mvvm/domain/repository/repository.dart';
import 'package:advance_mvvm/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}
