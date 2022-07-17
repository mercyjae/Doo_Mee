import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/Screens/Authentication/register.dart';
import 'package:rest_api/Utils/routers.dart';
import 'package:rest_api/Utils/snack_message.dart';
import 'package:rest_api/Widgets/button.dart';
import 'package:rest_api/Widgets/text_field.dart';

import '../../Provider/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      customTextField(
                          title: "Email",
                          controller: _email,
                          hint: "Enter your email address"),
                      customTextField(
                          title: "Password",
                          controller: _password,
                          hint: "Enter your secure password"),
                      Consumer<AuthProvider>(
                        builder: (context, auth,child) {
                         WidgetsBinding.instance!.addPostFrameCallback((_){
                           if(auth.resMessage != ""){
                             showMessage(
                               message: auth.resMessage,context: context
                             );
                             auth.clear();
                           }
                         });
                          return customButton(
                              text: "Login",
                              tap: () {
                                if(_email.text.isEmpty || _password.text.isEmpty){
                                  showMessage(message: "All fields are required",
                                      context:context
                                  );
                                }else{
                                  auth.loginUser(email: _email.text.trim(),context: context,
                                      password: _password.text.trim());
                                }
                              },
                              context: context,
                              status:auth.isLoading);
                        }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          PageNavigator(ctx: context)
                              .nextPage(page: Register());
                        },
                        child: Text("Register Instead"),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
