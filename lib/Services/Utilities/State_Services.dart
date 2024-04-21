import 'dart:convert';

import 'package:covid_tracker/Services/Utilities/Appurl.dart';
import 'package:http/http.dart' as http;

import '../../Model/WorldStateModel.dart';

class StateServices {
  Future<WorldStateModel> fetchWorkStateRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApis));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> countriesList() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
