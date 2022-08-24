class SignUpInResponse {
  late final String type;
  late final String message;
  late final Data data;

  SignUpInResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late final User user;
  late final String accessToken;
  late final String refreshToken;

  Data.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
}

class User {
  late final String userId;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String imageUrl;
  late final String role;

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    role = json['role'];
  }
}
