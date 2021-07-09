import 'package:bwatch_front/models/register_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/login_model.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://bwatch.herokuapp.com/api/v1/users/login";

    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(requestModel));

    return LoginResponseModel.fromJson(
      json.decode(response.body),
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
}
