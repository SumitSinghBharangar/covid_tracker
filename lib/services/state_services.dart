import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../models/dropdown_model.dart';
import '../models/world_state_model.dart';
import 'utilities/app_url.dart';

class StateServices {
  Future<WorldStateModel> fecthWorldStaterecord() async {
    final response = await http.get(Uri.parse(Appurl.worldstatesapi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception("error occured");
    }
  }

  Future<List<dynamic>> fecthCountryListApi() async {
    var data;
    final response = await http.get(Uri.parse(Appurl.countrylist));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("error occured");
    }
  }

  Future<List<DropDownModel>> getPostApi() async {
    try {
      final response = await http.get(Uri.parse(Appurl.dropapi));
      final body = jsonDecode(response.body) as List;
      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropDownModel(
            id: map["id"],
            body: map["body"],
            title: map["title"],
            userId: map["userid"],
          );
        }).toList();
      } else {
        throw Fluttertoast.showToast(msg: "Data Loading Failed");
      }
    } on SocketException {
      throw Exception("No Internet");
    }
  }
}