// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:course_getx/auth/auth_text_from_field%20copy.dart';
import 'package:course_getx/components/crud.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:course_getx/my_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> formstate = GlobalKey();

  final Crud _crud = Crud();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    if (formstate.currentState!.validate()) {
      var response = await _crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });

      if (response?['status'] == "Success") {
        Get.offAndToNamed("/home");
      } else {
        AwesomeDialog(
          context: context,
          title: "Alert",
          alignment: Alignment.center,
          body: const Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Not Found 404"),
                ]),
          ),
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formstate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 50, top: 80),
                      alignment: Alignment.topCenter,
                      child: Image.asset("images/logo1.png")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AuthTextFromField(
                      valid: (value) {
                        if (value.toString().length <= 2 ||
                            !RegExp(validationName).hasMatch(value!)) {
                          return 'Enter valid name';
                        } else {
                          return null;
                        }
                      },
                      mycontroller: username,
                      obscureText: false,
                      prefixIcon: const Icon(Icons.person),
                      hintText: 'User Name'),
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
                    mycontroller: password,
                    obscureText: true,
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
                        "If you have account",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.offAllNamed("/login");
                          },
                          child: const Text(
                            "Click Here",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await signUp();
                    },
                    child:
                        const Text("Sign Up", style: TextStyle(fontSize: 20)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
