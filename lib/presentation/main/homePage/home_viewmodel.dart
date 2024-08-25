import 'dart:async';
import 'dart:ffi';

import 'package:advance_mvvm/domain/model/model.dart';
import 'package:advance_mvvm/domain/usecase/home_usecase.dart';
import 'package:advance_mvvm/presentation/base/baseviewmodel.dart';
import 'package:advance_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advance_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel implements HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUseCase _homeUseCase;
  // final StreamController _serviceStreamController = BehaviorSubject<List<Service>>();
  // final StreamController _storeStreamController = BehaviorSubject<List<Store>>();
  // final StreamController _bannerStreamController = BehaviorSubject<List<BannerAd>>();

  final _dataStreamController = BehaviorSubject<HomeViewObject>();
  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHome();
    super.start();
  }

  _getHome() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _homeUseCase.execute(Void)).fold((failure){
      inputState.add(ErrorState(StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (homeObject){
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data.stores,
      homeObject.data.services,homeObject.data.banners));
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  // @override
  // Sink get inputBanners => _bannerStreamController.sink;
  //
  // @override
  // Sink get inputServices => _serviceStreamController.sink;
  //
  // @override
  // Sink get inputStores => _storeStreamController.sink;
  //
  // @override
  // Stream<List<BannerAd>> get outputBanners => _bannerStreamController.stream.map((banners) => banners);
  //
  // @override
  // Stream<List<Service>> get outputServices => _serviceStreamController.stream.map((services) => services);
  //
  // @override
  // Stream<List<Store>> get outputStores => _storeStreamController.stream.map((stores) => stores);

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data)=> data);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject{
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores,this.services,this.banners);
}
