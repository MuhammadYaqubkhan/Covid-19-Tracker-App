import 'package:covid_19_app/Model/world_states_model.dart';
import 'package:covid_19_app/services/utilities/app_url.dart';
import 'package:http/http.dart'as http;

import 'dart:convert';

class StatesServices {
  Future<WorldStatesModel> fechWorldStatesRecords() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> countriesListApi() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');
    }
  }
}