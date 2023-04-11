import 'package:coding_test/repository/home/model/homepage.model.dart';
import 'package:coding_test/repository/home/networking/homepage.networking.dart';
import 'package:flutter/material.dart';

class HomePageNotifier extends ChangeNotifier {

  final HomePageNetworking _homePageNetworking = HomePageNetworking();

  bool isLoading = false;

  late HomePageModel homePageModel;
  int selectedIndex = 0;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getAllDatas() async {
    loading(true);
    try {
      homePageModel = await _homePageNetworking.getAllDatas();
      loading(false);
      return homePageModel;
    } catch (e) {
      loading(false);
    }
  }

  deleteItem({required int index}) {
    homePageModel.data.remove(homePageModel.data[index]);
    notifyListeners();
  }
}
