// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rest_api/Provider/database_provider.dart';
import 'package:rest_api/Screens/Authentication/login.dart';
import 'package:rest_api/Screens/home_page.dart';
import 'package:rest_api/Utils/routers.dart';
import 'package:rest_api/main.dart';

import '../TaskPage/add_task.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }

  void navigate() {
    Future.delayed(Duration(seconds: 2), () {
      PageNavigator(ctx: context).nextPage(page: HomePage());
      // DataBaseProvider().getToken().then((value) {
      //   if(value == ""){
      //     PageNavigator(ctx: context).nextPageOnly(page: Login());
      //   }else{
      //     PageNavigator(ctx: context).nextPageOnly(page: HomePage());
      //   }
      // });

    });
  }
}
