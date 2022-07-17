import 'dart:convert';

import 'package:rest_api/Models/task_model.dart';

import '../Constants/url.dart';
import 'database_provider.dart';
import 'package:http/http.dart' as http;

class GetTask{
  final requestBaseUrl = AppUrl.baseUrl;
  Future <TaskModel>getTask() async{
    final token = await DataBaseProvider().getToken();
    final userId = await DataBaseProvider().getUserId();
    String url = "$requestBaseUrl/users/$userId/tasks?lastId=&pagination=20";
    try{
      final request = await http.get(Uri.parse(url),
      headers: {"Authorization": "Bearer $token"});
      if(request.statusCode == 200 || request.statusCode == 201){
     print(request.body);
     if(json.decode(request.body)["tasks"] == null){
       return  TaskModel();
     }else{
       final taskModel = taskModelFromJson(request.body);
       return taskModel;
     }
      }else{
        print(request.body);
        return TaskModel();
      }
    }catch(e){
      print(e);
      return Future.error(e.toString());
    }
  }

}