import 'package:coding_test/repository/register/model/register.model.dart';
import 'package:coding_test/repository/register/networking/register.networking.dart';
import 'package:flutter/material.dart';

class RegisterNotifier extends ChangeNotifier {

  final RegisterNetworking _registerNetworking = RegisterNetworking();

  bool isLoading = false;

  late RegisterModel registerModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  registerUser({required String email, required String password}) async {
    loading(true);
    try {
      registerModel = await _registerNetworking.registerUser(email: email, password: password);
      loading(false);
      return registerModel;
    } catch (e) {
      loading(false);
    }
  }
}
