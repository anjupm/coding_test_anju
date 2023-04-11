import 'package:coding_test/view/home/homepage.dart';
import 'package:coding_test/view/register/registerPage.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {

  '/registerPage': (context) => const RegisterPage(),
  '/homePage': (context) => HomePage(),

};
