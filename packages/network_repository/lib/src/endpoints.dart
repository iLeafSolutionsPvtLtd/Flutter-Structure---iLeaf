import 'package:network_repository/src/adapter.dart';
import 'package:network_repository/src/api_constants.dart';

enum EndPoint { appConfig, forecast, home, login }

extension URLExtension on EndPoint {
  String get url {
    switch (this) {
      case EndPoint.appConfig:
        return ApiConstants.appConfig;
      case EndPoint.forecast:
        return ApiConstants.path + ApiConstants.forecast;
      case EndPoint.home:
        return ApiConstants.path + ApiConstants.appHome;
      case EndPoint.login:
        return ApiConstants.path + ApiConstants.login;
    }
  }

  /// this method is used to replace | with id
  String cleanUrlWith(String id) {
    return url.replaceAll('|', id);
  }
}

extension RequestMode on EndPoint {
  RequestType get requestType {
    var requestType = RequestType.get;

    switch (this) {
      case EndPoint.appConfig:
      case EndPoint.forecast:
      case EndPoint.home:
        break;
      case EndPoint.login:
        requestType = RequestType.post;
    }
    return requestType;
  }
}

extension Token on EndPoint {
  bool get shouldAddToken {
    var shouldAdd = true;
    switch (this) {
      case EndPoint.appConfig:
      case EndPoint.forecast:
      case EndPoint.home:
        break;
      case EndPoint.login:
        shouldAdd = false;
    }
    return shouldAdd;
  }
}

extension FormType on EndPoint {
  FormRequestType get formType {
    var formType = FormRequestType.raw;
    switch (this) {
      case EndPoint.login:
      case EndPoint.forecast:
        break;
      case EndPoint.appConfig:
      case EndPoint.home:
        formType = FormRequestType.formData;
    }
    return formType;
  }
}
