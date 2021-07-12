import 'package:bwatch_front/models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/login_model.dart';

class APIService {
  String _token = 'init';
  String _firstName = 'init';
  String _lastName = 'init';
  int _tokenExp = -1;

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://bwatch.herokuapp.com/api/v1/users/login";

    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(requestModel));

    var jsonData = json.decode(response.body);

    _token = jsonData['token'];
    Map<String, dynamic> tokenData = JwtDecoder.decode(_token);

    _firstName = jsonData['firstName'];
    _lastName = jsonData['lastName'];
    _tokenExp = tokenData['exp'];
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'tokenExp': _tokenExp,
      'firstName': _firstName,
      'lastName': _lastName
    });

    prefs.setString('userData', userData);
    return LoginResponseModel.fromJson(
      jsonData,
    );
  }

  Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    String url = "https://bwatch.herokuapp.com/api/v1/users/sign-up";

    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(requestModel));

    return RegisterResponseModel.fromJson(
      json.decode(response.body),
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    _token = 'init';
    _tokenExp = -1;
    _firstName = 'init';
    _lastName = 'init';
  }

  // Future<bool> autoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   if (!prefs.containsKey('userData')) {
  //     _isAuth = false;
  //     return false;
  //   }
  //   final extractedUserData =
  //       json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
  //   final expDate = extractedUserData['tokenExp'];
  //   if (DateTime.now().millisecondsSinceEpoch >= expDate * 1000) {
  //     _isAuth = false;
  //     return false;
  //   }
  //   _token = extractedUserData['token'];
  //   _tokenExp = extractedUserData['tokenExp'];
  //   _firstName = extractedUserData['firstName'];
  //   _lastName = extractedUserData['lastName'];
  //   _isAuth = true;
  //   return true;
  // }
}
