import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart ' as http;
import 'package:rest_api/Provider/database_provider.dart';

import '../Constants/url.dart';

class AddTasKProvider extends ChangeNotifier{
  final requestBaseUrl = AppUrl.baseUrl;
 String _response ="";
 bool _status = false;

 get getResponse => _response;
 get getStatus  => _status;


 void addTask({String? title}) async {
  final token = await DataBaseProvider().getToken();
  final userId = await DataBaseProvider().getUserId();
  _status= true;
   notifyListeners();

   final url = "$requestBaseUrl/tasks/";

   final body ={
     "title":title,
     "startTime": "2022-01-18T11:01:00.000+00:00",
     "endTime": "2022-06-18T12:00:00.000+00:00",
     "userId": userId,
     "reminderPeriod": "2022-01-18T12:00:00.000+00:00"
   };
   try{
     final result = await http.post(Uri.parse(url),body:json.encode(body),
         headers: {"Authorization": "Bearer $token",});
     if(result.statusCode == 200|| result.statusCode ==201){
       final res = result.body;
       print(res);
       _response = json.decode(res)['message'];


       _status = false;
       notifyListeners();
     }else{
       //  final res = json.decode(result.body);
       final res = result.body;
       print(res);
       _response = json.decode(res)['message'];
       _status = false;
       notifyListeners();
     }
   }on SocketException catch(_){
    _status = false;
     _response = "Internet connection is not available";
     notifyListeners();
   } catch(e){
     _status = false;
     _response = "Please try again";
   //  print(_resMessage);
     notifyListeners();

   }


}
  void clear() {
   _response = '';
   notifyListeners();
  }

}