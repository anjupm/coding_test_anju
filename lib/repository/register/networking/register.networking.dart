import 'dart:convert';
import 'package:coding_test/repository/register/model/register.model.dart';
import 'package:http/http.dart' as http;

class RegisterNetworking {
  static const String urlENDPOINT = "https://reqres.in/api/register";

  final client = http.Client();

  late RegisterModel registerModel;

  Future<RegisterModel> registerUser(
      {required String email, required String password}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "email": email,
        "password": password,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        registerModel = RegisterModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return registerModel;
  }
}
