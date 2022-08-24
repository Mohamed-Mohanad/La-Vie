class UserDataResponse {
  late final String type;
  late final String message;
  late final User data;

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = User.fromJson(json['data']);
  }
}

class User {
  late final String userId;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String imageUrl;
  late final String address;
  late final String role;
  late final int userPoints;
  late final List<dynamic> userNotification;

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    address = json['address'] ?? "";
    role = json['role'];
    userPoints = json['UserPoints'] ?? 0;
    userNotification =
        List.castFrom<dynamic, dynamic>(json['UserNotification']);
  }
}
