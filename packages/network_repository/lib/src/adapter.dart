import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:network_repository/src/api_constants.dart';

import 'package:network_repository/src/endpoints.dart';
import 'package:network_repository/src/exceptions.dart';

enum RequestType {
  delete,
  get,
  patch,
  post,
  put,
}

enum FormRequestType {
  raw,
  formData,
}

class NetworkAdapter {
  NetworkAdapter._privateConstructor();
  static final NetworkAdapter shared = NetworkAdapter._privateConstructor();

  Future<dynamic> send({
    EndPoint? endPoint,
    Map<String, dynamic>? params,
    String? id,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final client = http.Client();
    // HttpClientWithMiddleware.build(middlewares: [
    //   HttpLogger(logLevel: LogLevel.BODY),
    // ]);
    Map<String, String>? headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      // 'version': 'v2',
    };
    if (endPoint!.shouldAddToken == true) {
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        // 'version': 'v2',
        // 'Authorization':
        // 'Bearer ${await SecureStorageHelper.shared.getToken()}',
      };
    }

    // if (params != null) {
    //   if (defaultTargetPlatform == TargetPlatform.iOS ||
    //       defaultTargetPlatform == TargetPlatform.android) {
    //     params["platform"] = Platform.isAndroid ? "android" : "ios";
    //   } else if (defaultTargetPlatform == TargetPlatform.linux ||
    //       defaultTargetPlatform == TargetPlatform.macOS ||
    //       defaultTargetPlatform == TargetPlatform.windows) {
    //     // Some desktop specific code there
    //   } else {
    //     // Some web specific code there
    //   }
    // }
    http.Response response;
    var url = '';
    if (id != null) {
      url = endPoint.cleanUrlWith(id);
    } else {
      url = endPoint.url;
    }

    try {
      Uri uri;
      uri = Uri.https(ApiConstants.baseUrl, url, params ?? {});

      switch (endPoint.requestType) {
        case RequestType.delete:
          response = await client.delete(uri, headers: headers);
        case RequestType.get:
          response = await client.get(uri, headers: headers);
        case RequestType.patch:
          response = await client.patch(uri, headers: headers);
        case RequestType.post:
          final uri = Uri.https(ApiConstants.baseUrl, url, {});
          response = await client.post(
            uri,
            headers: headers,
            body: json.encode(params),
          );
        case RequestType.put:
          response = await client.put(uri, headers: headers);
      }
    } on SocketException catch (exception) {
      log(exception.message);
      return 'ERROR:${exception.message}'; // If response is available.
    }
    log(response.body);
    return checkAndReturnResponse(response);
  }

  dynamic checkAndReturnResponse(http.Response response) {
    String? description; // App specific handling!
    var jsonResponse = <String, dynamic>{};
    try {
      log(response.body);
      jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return response.body;
    }
    description = jsonResponse.containsKey('message')
        ? jsonResponse['message'].toString()
        : null;
    switch (response.statusCode) {
      case 200:
      case 201:
        // Null check for response.data
        if (jsonResponse.isEmpty) {
          throw FetchDataException(
            'Returned response data is null : ${response.reasonPhrase}',
          );
        }
        return jsonResponse;
      case 400:
        throw BadRequestException(description ?? response.reasonPhrase);
      case 401:
      case 403:
        throw UnauthorizedException(description ?? response.reasonPhrase);
      case 404:
        throw NotFoundException(description ?? response.reasonPhrase);
      case 500:
        throw InternalServerException(description ?? response.reasonPhrase);
      default:
        throw FetchDataException(
          '''
Unknown error occurred\n\nerror Code: ${response.statusCode}  
error: ${response.reasonPhrase}''',
        );
    }
  }
}
