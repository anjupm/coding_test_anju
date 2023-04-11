import 'dart:convert';
import 'package:coding_test/repository/home/model/homepage.model.dart';
import 'package:http/http.dart' as http;

class HomePageNetworking {
  static const String urlENDPOINT = "https://reqres.in/api/users?page=1&per_page=12";

  final client = http.Client();

  late HomePageModel homePageModel;

  Future<HomePageModel> getAllDatas() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT)).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        homePageModel = HomePageModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return homePageModel;
  }
}
