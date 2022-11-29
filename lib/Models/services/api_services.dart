import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:http/http.dart' as http;

import 'app_exception.dart';

enum APIType { aPost, aGet, aPut }

class APIService {
  var response;
  String baseUrl = 'http://3.109.139.48:5000';

  @override
  Future getResponse(
      {required String url,
      required APIType apitype,
      Map<String, dynamic>? body,
      Map<String, String>? header,
      bool fileUpload = false}) async {
    Map<String, String> headers = GetStorageServices.getBarrierToken() != null
        ? {
            'Authorization': 'Bearer ${GetStorageServices.getBarrierToken()}',
            'Content-Type': 'application/json'
          }
        : {'Content-Type': 'application/json'};
    try {
      if (apitype == APIType.aGet) {
        final result =
            await http.get(Uri.parse(baseUrl + url), headers: headers);
        response = returnResponse(result.statusCode, result.body);
        log("RES status code ${result.statusCode}");
        log("res${result.body}");
      } else if (apitype == APIType.aPost) {
        print("REQUEST PARAMETER url  $url");
        print("REQUEST PARAMETER $body");

        final result = await http.post(Uri.parse(baseUrl + url),
            body: json.encode(body), headers: headers);
        print("resp${result.body}");
        response = returnResponse(result.statusCode, result.body);
        print(result.statusCode);
      } else {
        print("REQUEST PARAMETER url  $url");
        print("REQUEST PARAMETER $body");

        final result = await http.put(Uri.parse(baseUrl + url),
            body: json.encode(body), headers: headers);
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
