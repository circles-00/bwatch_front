import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

// ignore: non_constant_identifier_names
Future<String> getProfileImage(String id) async {
  var response = await http.get(
      Uri.parse('$api_base_url/api/v1/users/profile-img/'),
      headers: {"id": id});

  var jsonData = json.decode(response.body);

  if (response.statusCode == 200) {
    var imgUrl = jsonData['url'];
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'profileImgUrl',
      imgUrl,
    );

    return imgUrl.toString();
  }
  return 'null';
}
