import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:agriculture_aficionado/Components/token.dart';
import 'package:agriculture_aficionado/Model/chatModel.dart';
import 'package:agriculture_aficionado/Model/modelsmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse('$Base_url/models'),
        headers: {
          'Authorization': 'Bearer $Api_key',
        },
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      List temp = [];
      for (var i in jsonResponse['data']) {
        temp.add(i);
      }
      if (kDebugMode) {
        print(temp);
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (e) {
      log("error $e");
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessages(String message) async {
    try {
      var response = await http.post(
        Uri.parse('$Base_url/completions'),
        headers: {
          'Authorization': 'Bearer $Api_key',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo-instruct",
            "prompt": message,
            "max_tokens": 100,
          },
        ),
      );

      Map jsonResponse = json.decode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];

      if (jsonResponse['choices'].length > 0) {
        // log(jsonResponse['choices'][0]['text']);
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
            msg: jsonResponse['choices'][index]['text'],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (e) {
      log("error $e");
      rethrow;
    }
  }
}
