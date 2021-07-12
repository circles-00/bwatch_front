class LoginResponseModel {
  final String status;
  final String firstName;
  final String lastName;
  final String token;

  LoginResponseModel(
      {required this.status,
      required this.firstName,
      required this.lastName,
      required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'],
      firstName: json['firstName'],
      lastName: json['lastName'],
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
