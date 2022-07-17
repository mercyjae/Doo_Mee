import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rest_api/Constants/url.dart';
import 'package:http/http.dart ' as http;
import 'package:rest_api/Provider/database_provider.dart';
import 'package:rest_api/main.dart';

import '../../Screens/Authentication/login.dart';
import '../../Utils/routers.dart';
import '../Screens/TaskPage/add_task.dart';
import '../Screens/home_page.dart';

class AuthProvider extends ChangeNotifier {

  final requestBaseUrl = AppUrl.baseUrl;

  bool _isLoading = false;
  String _resMessage = "";

  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    BuildContext? context,}) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/users/";
    final body = {
      "firstName": "firstName",
      "lastName": "lastName",
      "email": "email",
      "password": "password"
    };
    print(body);
    try{
      http.Response req = await http.post(Uri.parse(url),body: json.encode(body));
      if(req.statusCode == 200 || req.statusCode == 201){
        final res = json.decode(req.body);
        _resMessage = res['message'];
      print(res);
        _resMessage = "Account created";
        _isLoading = false;
        notifyListeners();
        PageNavigator(ctx: context).nextPage(page: Login());
      } else {
        final res = json.decode(req.body);
        _resMessage = res["message"];
        print(res);
        _isLoading = false;
        notifyListeners();

      }

    }on SocketException catch(_){
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch(e){
      _isLoading = false;
      _resMessage = "Please try again";
      print(e.toString());
      notifyListeners();

    }
  }


  void loginUser({
    required String email,
    required String password,
    BuildContext? context,}) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/users/login";
    final body = {
      "email": "email",
      "password": "password"
    };
    print(body);
    try{
      http.Response req = await http.post(Uri.parse(url),body: json.encode(body));
      if(req.statusCode == 200|| req.statusCode == 201){
        final res = json.decode(req.body);
        print(res);
        _resMessage = "Login Successful";
        _isLoading = false;
        notifyListeners();
           final userId = res["user"]["id"];
           final token = res["authToken"];
           DataBaseProvider().saveToken(token);
           DataBaseProvider().saveUserId(userId);
        PageNavigator(ctx: context).nextPage(page: HomePage());

      }else{
        final res = json.decode(req.body);
        _resMessage = res['message'];
        print(res);
        _isLoading = false;
        notifyListeners();

      }

    }on SocketException catch(_){
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch(e){
      _isLoading = false;
      _resMessage = "Please try again";
      print(_resMessage);
      notifyListeners();

    }
  }
  void clear(){
    _resMessage = "";
    notifyListeners();
  }

}
