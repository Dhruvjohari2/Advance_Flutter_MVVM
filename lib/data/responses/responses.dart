import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse(this.name, this.id, this.numOfNotifications);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "link")
  String? link;

  ContactResponse(this.email, this.link, this.phone);

  factory ContactResponse.fromJson(Map<String, dynamic> json) => _$ContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactResponse? contacts;

  AuthenticationResponse(this.contacts, this.customer);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgetPasswordResponse(this.support);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => _$ForgetPasswordResponseFromJson(json);
}

@JsonSerializable()
class ServiceResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  ServiceResponse(this.id, this.title, this.image);

  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);

  factory ServiceResponse.fromJson(Map<String, dynamic> json) => _$ServiceResponseFromJson(json);
}

@JsonSerializable()
class StoreResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  StoreResponse(this.id, this.title, this.image);

  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);

  factory StoreResponse.fromJson(Map<String, dynamic> json) => _$StoreResponseFromJson(json);
}

@JsonSerializable()
class BannerResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'link')
  String? link;

  BannerResponse(this.id, this.title, this.image,this.link);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);

  factory BannerResponse.fromJson(Map<String, dynamic> json) => _$BannerResponseFromJson(json);
}

@JsonSerializable()
class HomeDataResponse{
  @JsonKey(name:'services')
  List<ServiceResponse>? service;
  @JsonKey(name:'stores')
  List<StoreResponse>? stores;
  @JsonKey(name:'banners')
  List<BannerResponse>? banner;

  HomeDataResponse(this.service, this.stores, this.banner);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) => _$HomeDataResponseFromJson(json);

}

@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name:'data')
  HomeDataResponse? data;

  HomeResponse(this.data);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

}

@JsonSerializable()
class StoreDetailResponse extends BaseResponse {
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'detail')
  String? detail;
  @JsonKey(name: 'service')
  String? service;
  @JsonKey(name: 'about')
  String? about;


  StoreDetailResponse(this.image,this.id,this.title,this.detail,this.service,this.about);

  Map<String, dynamic> toJson() => _$StoreDetailResponseToJson(this);

  factory StoreDetailResponse.fromJson(Map<String, dynamic> json) => _$StoreDetailResponseFromJson(json);
}

