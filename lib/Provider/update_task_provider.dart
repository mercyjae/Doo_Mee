import 'package:flutter/material.dart';
import 'package:rest_api/Provider/database_provider.dart';
import 'package:http/http.dart' as http;

import '../Constants/url.dart';

class UpdateTaskProvider extends ChangeNotifier{
  final requestBaseUrl = AppUrl.baseUrl;
  String getMessage = "";
  bool getStatus = false;
  get message => getMessage;
  get status => getStatus;

  void UpdateTask({String? title, String? taskId}) async{
    final token = await DataBaseProvider().getToken();
    final userId = await DataBaseProvider().getUserId();
    getStatus = true;
    notifyListeners();

    final url = "$requestBaseUrl/tasks/$taskId";


    final body =   {
      "status": "COMPLETED"
    };
    final request = await http.put(Uri.parse(url));
    if(request.statusCode == 200 || request.statusCode == 201){
      final res = request.body;
      print(res);
      getStatus= false;
      notifyListeners();
    }else {
      final res = request.body;
      print(res);
      getStatus = false;
      notifyListeners();

    }

  }

}