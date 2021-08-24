class LoginResponseModel {
  final String status;
  final String firstName;
  final String lastName;
  final String token;
  final String id;

  LoginResponseModel(
      {required this.status,
      required this.firstName,
      required this.lastName,
      required this.token,
      required this.id});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        status: json['status'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        token: json['token'],
        id: json['id']);
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
