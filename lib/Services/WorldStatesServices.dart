import 'dart:convert';
import 'package:covidtracker_app/Services/Utilities/api_url.dart';
import 'package:http/http.dart' as http;
import '../Models/WorldStatesModel.dart';
class WorldStateServices{
  Future<WorldStatesModel> getWorldRecords() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesUrl));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }
    else{
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> countriesListApi() async {
    var data ;
    final response = await http.get(Uri.parse(AppUrl.countries_url));
    print(response.statusCode.toString());
    print(data);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }
  }