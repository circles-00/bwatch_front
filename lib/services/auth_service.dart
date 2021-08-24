import 'package:bwatch_front/models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../constants.dart';
import '../models/login_model.dart';

class APIService {
  String _token = 'init';
  String _firstName = 'init';
  String _lastName = 'init';
  int _tokenExp = -1;
  String _id = 'init';

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "$api_base_url/api/v1/users/login";

    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(requestModel));

    var jsonData = json.decode(response.body);

    if (jsonData['status'] == 'success') {
      _token = jsonData['token'];
      Map<String, dynamic> tokenData = JwtDecoder.decode(_token);

      _firstName = jsonData['firstName'];
      _lastName = jsonData['lastName'];
      _tokenExp = tokenData['exp'];
      _id = tokenData['id'];
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'tokenExp': _tokenExp,
        'firstName': _firstName,
        'lastName': _lastName,
        'id': _id
      });
      await prefs.setString('userData', userData);
      return LoginResponseModel.fromJson({
        'status': jsonData['status'],
        'token': _token,
        'firstName': _firstName,
        'lastName': _lastName,
        'id': _id
      });
    } else {
      return LoginResponseModel.fromJson({
        'token': 'fail',
        'status': 'failed',
        'firstName': 'fail',
        'lastName': 'fail',
        'id': 'fail'
      });
    }
  }

  Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    String url = "$api_base_url/api/v1/users/sign-up";

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
    await prefs.clear();
    _token = 'init';
    _tokenExp = -1;
    _firstName = 'init';
    _lastName = 'init';
    _id = 'init';
  }

  static Future<Map<String, dynamic>?> getJWT() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      var userData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      var jwt = userData['token'];
      if (jwt == "init") {
        return null;
      }
      return userData;
    }
    return null;
  }
}
