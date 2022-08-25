class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  String? address;
  String? role;
  int? userPoints;
  List<UserNotification>? userNotification;

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    address = json['address'];
    role = json['role'];
    userPoints = json['UserPoints'];
    if (json['UserNotification'] != null) {
      userNotification = <UserNotification>[];
      json['UserNotification'].forEach((v) {
        userNotification!.add(new UserNotification.fromJson(v));
      });
    }
  }
}

class UserNotification {
  String? notificationId;
  String? userId;
  String? imageUrl;
  String? message;
  DateTime? createdAt;

  UserNotification.fromJson(Map<String, dynamic> json) {
    notificationId = json['notificationId'];
    userId = json['userId'];
    imageUrl = json['imageUrl'];
    message = json['message'];
    createdAt = DateTime.parse(json['createdAt']);
  }
}
