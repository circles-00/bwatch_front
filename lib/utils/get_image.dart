import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
Future<String> getProfileImage(String token) async {
  // print(token);
  var response = await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/users/profile-img/'),
      headers: {"authorization": "Bearer $token"});

  var jsonData = json.decode(response.body);

  if (response.statusCode == 200) {
    // print('Image successfully uplaoded');
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
