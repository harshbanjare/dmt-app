import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dmt/pages/chat/model/BaseBean.dart';
import 'package:dmt/pages/chat/model/ChatBean.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatApiService {
  Future<ChatBean> getMessages(Map<String, String> sendParam) async {
    print(sendParam);
    String url = "https://dmtransport.in/api/getmessages";

    final response = await http.post(Uri.parse(url), body: sendParam);
    if (response.statusCode == 200 || response.statusCode == 400) {
      // print(response.body);
      return ChatBean.fromJson(
        json.decode(response.body),
      );
    } else {
      print("ERRRRROOOORRRRRRRRRRRRR GETTTT");
      print(response.body);
      throw Exception('Failed to load data!');
    }
  }

  Future<BaseBean> sendMessage(Map sendParam) async {
    String url = "https://dmtransport.in/api/sendmessage";

    if (sendParam["doc"] != null) {
      // print("HIIIIIIIIII");
      // var postUri = Uri.parse(url);
      // var request = new http.MultipartRequest("POST", postUri);
      // request.fields['message'] = sendParam["message"];
      // request.fields['token'] = sendParam["token"];
      // request.fields['coversation_type'] = sendParam["coversation_type"];
      // request.files.add(new http.MultipartFile.fromBytes('doc',
      //     await File.fromUri(Uri.parse(sendParam["doc"])).readAsBytes()));

      FormData formData = FormData.fromMap({
        "message": sendParam["message"],
        "token": sendParam["token"],
        "coversation_type": sendParam["coversation_type"],
        "doc": await MultipartFile.fromFile(sendParam["doc"]),
      });

      print(sendParam["message"]);
      var response = await Dio()
          .post("https://dmtransport.in/api/sendmessage", data: formData);

      print(response);

      // request.send().then((response) {
      //   if (response.statusCode == 200 || response.statusCode == 400) {
      //     print(response);
      //     // return BaseBean.fromJson(
      //     //   json.decode(response.body),
      //     // );
      //   } else {
      //     throw Exception('Failed to load data!');
      //   }
      // });
    } else {
      final response = await http.post(Uri.parse(url), body: sendParam);
      if (response.statusCode == 200 || response.statusCode == 400) {
        print("ASDFGHJKJG");
        print(response.body);
        return BaseBean.fromJson(
          json.decode(response.body),
        );
      } else {
        debugPrint('Failed to load data!');
      }
    }
    return BaseBean.fromJson(
      {},
    );
  }
}
