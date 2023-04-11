import 'package:coding_test/storage/storage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkLogin();
    });
  }

  void checkLogin() async {
    LocalStorage localStorage = LocalStorage();
    await localStorage.getToken().then((value) {
      if (value != null) {
        Navigator.pushReplacementNamed(context, '/homePage');
      } else {
        Navigator.pushReplacementNamed(context, '/registerPage');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/icons/logo.png",
          height: 100,
        ),
      ),
    );
  }
}
