class AuthenticationModel {
  late final String type;
  late final String message;
  late final UseAuthData useAuthData;

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    useAuthData = UseAuthData.fromJson(json['data']);
  }
}

class UseAuthData {
  late final String userId;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String imageUrl;
  late final String role;
  late final String accessToken;
  late final String refreshToken;

  UseAuthData.fromJson(Map<String, dynamic> json) {
    userId = json['user']['userId'];
    firstName = json['user']['firstName'];
    lastName = json['user']['lastName'];
    email = json['user']['email'];
    imageUrl = json['user']['imageUrl'];
    role = json['user']['role'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
}
