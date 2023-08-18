import 'dart:convert';

import 'package:http/http.dart' as http;

import 'DataModel.dart';

class ApiServices {
  Future<List<DataModel>> getVideosAPI() async {
    var url = Uri.parse(
        'https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List dataList = json.decode(response.body);
      return dataList.map((data) => DataModel.fromJson(data)).toList();
    } else {
      throw Exception('Error!');
    }
  }
}
