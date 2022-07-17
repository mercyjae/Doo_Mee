import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/Provider/addtask_provider.dart';
import 'package:rest_api/Provider/database_provider.dart';
import 'package:rest_api/Provider/deletetask_provider.dart';
import 'package:rest_api/Screens/Authentication/splash.dart';
import 'package:rest_api/Styles/colors.dart';

import 'Provider/auth_provider.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthProvider()),
        ChangeNotifierProvider(create: (_)=> DataBaseProvider()),
        ChangeNotifierProvider(create: (_)=>AddTasKProvider()),
        ChangeNotifierProvider(create: (_)=>DeleteTaskProvider())
      ],
      child:
      MaterialApp(debugShowCheckedModeBanner: false,
        theme: ThemeData(appBarTheme: AppBarTheme(color: primaryColor),

            primaryColor: primaryColor),
        home: Splash(),
      ),
    );
  }
}
