import 'package:flutter/cupertino.dart';
import 'package:rest_api/Provider/database_provider.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/Screens/home_page.dart';
import 'package:rest_api/Utils/routers.dart';
import 'dart:convert';

import '../Constants/url.dart';
import '../Screens/Authentication/login.dart';

class DeleteTaskProvider extends ChangeNotifier{
  final requestBaseUrl = AppUrl.baseUrl;
  bool _status = false;
  String _response = "";

  get status => _status;
  get response => _response;


  void deleteTask({String? taskId, BuildContext? context}) async{
    final token = await DataBaseProvider().getToken();
    _status = false;
    notifyListeners();

    final url = "$requestBaseUrl/tasks/$taskId";
    final result = await http.delete(Uri.parse(url),
    headers: {"Authorization" : "Bearer $token"});

    if(result.statusCode == 200|| result.statusCode ==201){
      final res = result.body;
      _status= false;
      print(res);
      _response = json.decode(res)['message'];
      PageNavigator(ctx: context).nextPageOnly(page: HomePage());
      notifyListeners();

    }else{
      final res = result.body;
      print(res);
      _status = false;
      _response = json.decode(res)['message'];
      notifyListeners();
    }
  }
}