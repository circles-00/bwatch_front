class RegisterResponseModel {
  final String status;
  final String token;

  RegisterResponseModel({required this.status, required this.token});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      status: json['status'],
      token: json['token'],
    );
  }
}

class RegisterRequestModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String passwordConfirm;

  RegisterRequestModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.passwordConfirm});

  Map toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm
    };
  }
}
