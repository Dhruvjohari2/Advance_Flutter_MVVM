import 'dart:async';

import 'package:advance_mvvm/domain/model/model.dart';
import 'package:advance_mvvm/domain/usecase/home_usecase.dart';
import 'package:advance_mvvm/presentation/base/baseviewmodel.dart';

class HomeViewModel extends BaseViewModel{

  final HomeUseCase _homeUseCase;
  final StreamController _serviceStreamController = StreamController<List<Service>>();
  final StreamController _storeStreamController = StreamController<List<Store>>();
  final StreamController _bannerStreamController = StreamController<List<BannerAd>>();
  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    // TODO: implement start
    super.start();
  }
  @override
  void dispose() {
    _serviceStreamController.close();
    _storeStreamController.close();
    _bannerStreamController.close();
    super.dispose();
  }
}