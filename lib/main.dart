import 'package:course_getx/auth/login.dart';
import 'package:course_getx/auth/signup.dart';
import 'package:course_getx/view/addnotes.dart';
import 'package:course_getx/view/editnote.dart';
import 'package:course_getx/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharepref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharepref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: sharepref!.getString("id") == null ? "/login" : "/home",
      theme: ThemeData.light(),
      getPages: [
        GetPage(name: "/home", page: () => HomePage()),
        GetPage(name: "/login", page: () => const Login()),
        GetPage(name: "/signup", page: () => const Signup()),
        GetPage(name: "/addnotes", page: () => const AddNotes()),
        GetPage(name: "/editnotes", page: () => const EditNotes()),
      ],
    );
  }
}
