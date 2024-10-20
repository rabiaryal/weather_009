
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weather_009/data/app_expection.dart';
import 'package:weather_009/data/network/base_api_services.dart';


class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetAPiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchException('No internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostAPiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchException('No internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());

      case 404:
        throw UnAuthorizedException(response.body.toString());

      default:
        throw FetchException(
          'Error Occured while communitating with server' 'With Status code' +
              response.statusCode.toString(),
        );
    }
  }
}
