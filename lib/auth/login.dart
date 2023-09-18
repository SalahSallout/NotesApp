// ignore_for_file: use_build_context_synchronously

import 'package:course_getx/auth/auth_text_from_field%20copy.dart';
import 'package:course_getx/components/crud.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:course_getx/main.dart';
import 'package:course_getx/my_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();

  login() async {
    if (formstate.currentState!.validate()) {
      isLoding = true;
      setState(() {});
      var response = await crud.postRequest(
          linkLogIn, {"email": email.text, "password": password.text});
      isLoding = false;
      setState(() {});
      if (response?['status'] == "Success") {
        sharepref!.setString("id", response['data']['id'].toString());
        sharepref!.setString("username", response['data']['username']);
        sharepref!.setString("email", response['data']['email']);
        Get.offAndToNamed("/home");
      } else {
        AwesomeDialog(
          context: context,
          title: "Alert",
          alignment: Alignment.center,
          body: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "The Email Or The Pasword Is an Error Or The Account Not Found"),
              ]),
        ).show();
      }
    }
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud crud = Crud();
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formstate,
          child: SingleChildScrollView(
            child: isLoding == true
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Center(
                        child: Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(bottom: 50),
                            alignment: Alignment.topCenter,
                            child: Image.asset("images/logo1.png")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AuthTextFromField(
                          mycontroller: email,
                          obscureText: false,
                          prefixIcon: const Icon(Icons.email_rounded),
                          hintText: 'Email',
                          valid: (value) {
                            if (!RegExp(validationEmail).hasMatch(value!)) {
                              return 'Invalid email';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AuthTextFromField(
                          obscureText: true,
                          mycontroller: password,
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          hintText: 'Password',
                          valid: (value) {
                            if (value.toString().length < 6) {
                              return 'Password should be longer or equal to 6 characters';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const Text(
                              "If you havan't account",
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.offAllNamed("/signup");
                                },
                                child: const Text(
                                  "Click Here",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await login();
                          },
                          child: const Text(
                            "Log In",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
