import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dmt/pages/util/ApiUrl.dart';

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}

class ApiBaseHelper {
  // String baseUrl = "http://dm.ajeetwork.xyz/api/";
  String baseUrl = ServiceUrl.baseUrl + "api/";

  Future<dynamic> get(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token =
        (prefs.getString('token') != null ? prefs.getString('token') : "");
    var kHeader = {
      "Authorization": "Bearer " + token!,
      "Content-Type": "application/x-www-form-urlencoded",
    };
    print("HEADERS::::::::: " + kHeader.toString());
    print("Url " + baseUrl + url);

    var responseJson;
    try {
      final response =
          await http.get(Uri.parse(baseUrl + url), headers: kHeader);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, params) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      return {"status": false};
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token =
        (prefs.getString('token') != null ? prefs.getString('token') : "");
    print('login_token ' + token!);

    var kHeader = {
      "Authorization": "Bearer " + token,
      "Content-Type": "application/x-www-form-urlencoded",
    };
    print("HEADERS::::::::: " + kHeader.toString());
    print("Url " + baseUrl + url);
    try {
      final response = await http.post(Uri.parse(baseUrl + url),
          body: params, headers: kHeader);
      log("FINAL RESPONSE ::::::::: " + response.body);
      try {
        return jsonDecode(response.body);
      } on FormatException catch (e) {
        print('error ${e.toString()}');
      }
    } on SocketException catch (e) {
      print('error api error.................');
    }
    print('error after webcall.................');
  }

  Future<dynamic> multiPart(
      url, params, String filePath, String mediaName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token =
        (prefs.getString('token') != null ? prefs.getString('token') : "");
    print('login_token ' + token!);
    var kHeaderMultiPart = {
      "Authorization": "Bearer " + token,
      "Content-Type": "multipart/form-data",
      // "Content-Type": "multipart/form-data;boundary=alamofire.boundary.bd5f22f730a6c10d"
    };
    print("HEADERS::::::::: " + kHeaderMultiPart.toString());
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      return {"status": false};
    }

    final multipartRequest =
        new http.MultipartRequest('POST', Uri.parse(baseUrl + url));
    multipartRequest.fields.addAll(params);
    multipartRequest.headers.addAll(kHeaderMultiPart);
    var pic = await http.MultipartFile.fromPath(mediaName, filePath);
    multipartRequest.files.add(pic);
    try {
      final response = await multipartRequest.send();
      print("error after response.........$response");
      try {
        var responseByteArray = await response.stream.toBytes();
        print('error1111 ${utf8.decode(responseByteArray)}');
        return json.decode(utf8.decode(responseByteArray));
      } on FormatException catch (e) {
        var err = e.toString();
        err.split('<').map((i) {
          print('${i.toString()}');
        });

        print('error11 ${e.toString()}');
        return {"status": false};
      }
    } on SocketException catch (e) {
      //throw FetchDataException('No Internet connection');
      print('error api error.................');
      return {"status": false};
    }
  }

  // Future<String?> uploadImage(filepath, url) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(await http.MultipartFile.fromPath('image', filepath));
  //   var res = await request.send();
  //   return res.reasonPhrase;
  // }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // print("ERROR::"+response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
