import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';

// ignore: non_constant_identifier_names
Future<String> ImageUpload(String path, String token) async {
  Map<String, String> header = {"authorization": "Bearer $token"};
  var request = http.MultipartRequest(
      "POST", Uri.parse('$api_base_url/api/v1/users/upload/profile-img'));
  request.headers.addAll(header);
  request.files.add(await http.MultipartFile.fromPath('image', path));
  var response = await request.send();
  var status = 'init';
  if (response.statusCode == 200) {
    // print('Image successfully uplaoded');
    status = await response.stream.bytesToString();
    var jsonData = json.decode(status);
    var imgUrl = jsonData['url'];
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString(
    //   'profileImgUrl',
    //   imgUrl,
    // );

    return imgUrl.toString();
  }
  return 'null';
}
