import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'app_exception.dart';

enum APIType { aPost, aGet }

class APIService {
  var response;
  String baseUrl = 'https://theprimoapp.com/meyaoo/api/';
  Map<String, String> headers = {
    "Accept": "application/json",
  };
  @override
  Future getResponse(
      {required String url,
      required APIType apitype,
      Map<String, dynamic>? body,
      Map<String, String>? header,
      bool fileUpload = false}) async {
    try {
      if (apitype == APIType.aGet) {
        final result =
            await http.get(Uri.parse(baseUrl + url), headers: header);
        response = returnResponse(result.statusCode, result.body);
        log("RES status code ${result.statusCode}");
        log("res${result.body}");
      } else {
        print("REQUEST PARAMETER url  $url");
        print("REQUEST PARAMETER $body");

        final result = await http.post(Uri.parse(baseUrl + url),
            body: body, headers: header);
        print("resp${result.body}");
        response = returnResponse(result.statusCode, result.body);
        print(result.statusCode);
      }
    } on SocketException {
      throw FetchDataException('No Internet access');
    }

    return response;
  }

  returnResponse(int status, String result) {
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 201:
        return jsonDecode(result);
      case 400:
        return jsonDecode(result);
      // throw BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
