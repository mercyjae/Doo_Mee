import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/Screens/Authentication/login.dart';

import 'package:rest_api/Utils/routers.dart';
import 'package:rest_api/Utils/snack_message.dart';
import 'package:rest_api/Widgets/button.dart';
import 'package:rest_api/Widgets/text_field.dart';

import '../../Provider/auth_provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    _firstName.clear();
    _lastName.clear();
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
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
                          title: "First  Name",
                          controller: _firstName,
                          hint: "Enter your first name"),
                      customTextField(
                          title: "Last Name",
                          controller: _lastName,
                          hint: "Enter your last name"),
                      customTextField(
                          title: "Email",
                          controller: _email,
                          hint: "Enter your email address"),
                      customTextField(
                          title: "Password",
                          controller: _password,
                          hint: "Enter your secure password"),
                      Consumer<AuthProvider>(
                        builder: (context, auth, child) {
                          WidgetsBinding.instance!.addPostFrameCallback((_){
                            if(auth.resMessage != ""){
                              showMessage(
                                  message: auth.resMessage,context: context);

                              auth.clear();
                            }
                          });
                          return customButton(
                              text: "Register",
                              tap: () {
                                if(_email.text.isEmpty
                                    || _password.text.isEmpty
                                    ||_firstName.text.isEmpty
                                ||_lastName.text.isEmpty){
                                  showMessage(message: "All fields are required",context: context);
                                } else {

                                  auth.registerUser(email: _email.text.trim(),
                                      firstName:_firstName.text.trim(),
                                      lastName:_lastName.text.trim(),
                                      password: _password.text.trim(),
                                  context:context);
                                }
                              },
                              context: context,
                              status: auth.isLoading);
                        }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          PageNavigator(ctx: context).nextPage(page: Login());
                        },
                        child: Text("Login Instead"),
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
