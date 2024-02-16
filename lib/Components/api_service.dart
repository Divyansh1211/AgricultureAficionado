import 'dart:convert';
import 'dart:developer';

import 'package:agriculture_aficionado/Components/token.dart';
import 'package:agriculture_aficionado/Model/modelsmodel.dart';
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
      Map jsonResponse = json.decode(response.body);
      List temp = [];
      for (var i in jsonResponse['data']) {
        temp.add(i);
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } on Exception {
      rethrow;
    }
  }
}
