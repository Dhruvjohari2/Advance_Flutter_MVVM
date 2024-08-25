import 'package:advance_mvvm/app/extension.dart';
import 'package:advance_mvvm/data/responses/responses.dart';
import 'package:advance_mvvm/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  //toDomain means converting data layer to  Domain(model)
  Customer toDomain() {
    return Customer(this?.id.orEmpty() ?? EMPTY, this?.name?.orEmpty() ?? EMPTY, this?.numOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactResponse? {
  //toDomain means converting data layer to  Domain(model)
  Contact toDomain() {
    return Contact(this?.email.orEmpty() ?? EMPTY, this?.phone?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  //toDomain means converting data layer to  Domain(model)
  Authentication toDomain() {
    return Authentication(this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? EMPTY;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY, this?.image?.orEmpty() ?? EMPTY);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY, this?.image?.orEmpty() ?? EMPTY);
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY, this?.image?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> mappedServices = (this?.data?.service?.map((service) => service.toDomain()) ?? const Iterable.empty()).cast<Service>().toList();
    List<Store> mappedStores = (this?.data?.stores?.map((store) => store.toDomain()) ?? const Iterable.empty()).cast<Store>().toList();
    List<BannerAd> mappedBanners = (this?.data?.banner?.map((bannerAd) => bannerAd.toDomain()) ?? const Iterable.empty()).cast<BannerAd>().toList();

    var data = HomeData(mappedServices, mappedStores, mappedBanners);
    return HomeObject(data);
  }
}

extension StoreDetailResponseMapper on StoreDetailResponse? {
  StoreDetail toDomain() {
    return StoreDetail(this?.image?.orEmpty() ?? EMPTY, this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
    this?.detail?.orEmpty() ?? EMPTY, this?.service?.orEmpty() ?? EMPTY,this?.about?.orEmpty() ?? EMPTY,);
  }
}
