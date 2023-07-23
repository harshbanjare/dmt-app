class LoginResponseModel {
  final String token;
  final String error;

  LoginResponseModel({required this.token, required this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] ?? "",
      error: json["error"] ?? "",
    );
  }
}

class LoginRequestModel {
  String email;
  String password;
  String os_user_id;


  LoginRequestModel({
    required this.email,
    required this.password,
    required this.os_user_id,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
      'player_id': os_user_id.trim(),
    };

    return map;
  }
}
