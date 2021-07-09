class LoginResponseModel {
  final String status;
  final String token;

  LoginResponseModel({required this.status, required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'],
      token: json['token'],
    );
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map toJson() {
    return {'email': email, 'password': password};
  }
}
