import 'package:advance_mvvm/app/extension.dart';
import 'package:advance_mvvm/data/responses/responses.dart';
import 'package:advance_mvvm/domain/model.dart';

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
    return Authentication(this?.customer?.toDomain(), this?.contact?.toDomain());
  }
}
