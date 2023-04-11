import 'package:coding_test/common/widget/bookingFormTextFields.dart';
import 'package:coding_test/repository/register/notifier/register.notifier.dart';
import 'package:coding_test/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Platform.isAndroid) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        } else if (Platform.isIOS) {
          exit(0);
        }
        return Future.value(false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/icons/logo.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Welcome Back!",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Login to your existing account",
                  style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BookingFormTextFields(
                    hint: "Email",
                    controller: emailController,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: BookingFormTextFields(
                    hint: "Password",
                    maxLines: 1,
                    controller: passwordController,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.openSans(
                        color: Colors.pink.shade900,
                      ),
                    ),
                  ),
                ),
                Consumer<RegisterNotifier>(builder: (context, data, _) {
                  return Container(
                    padding: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: data.isLoading
                        ? Center(
                            heightFactor: 1,
                            widthFactor: 1,
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.pink.shade700,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              if (emailController.text.isEmpty &&
                                  passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.pink.shade700,
                                    content:
                                        const Text("Please fill all fields"),
                                  ),
                                );
                              } else {
                                try {
                                  await data.registerUser(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );

                                  if (data.registerModel.token.isNotEmpty) {
                                    //save token in local storage
                                    LocalStorage localStorage = LocalStorage();
                                    await localStorage.setToken(data.registerModel.token);
                                    Navigator.of(context).pushNamed("/homePage");
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.pink.shade700,
                                        content: Text("Something went wrong!"),
                                      ),
                                    );
                                  }
                                } catch (_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.pink.shade700,
                                      content: const Text("Something went wrong!"),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade700,
                            ),
                            child: Text(
                              "Submit",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                              ),
                            ),
                          ),
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "or connect using",
                  style: GoogleFonts.openSans(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/homePage");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade700,
                      ),
                      child: Wrap(
                        children: [
                          const Icon(Icons.facebook, size: 15),
                          const SizedBox(
                            width: 5,
                          ),
                          Center(
                            child: Text(
                              "Facebook",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/homePage");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade700,
                      ),
                      child: Wrap(
                        children: [
                          const Icon(
                            Icons.g_mobiledata_rounded,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Center(
                            child: Text(
                              "Google",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
