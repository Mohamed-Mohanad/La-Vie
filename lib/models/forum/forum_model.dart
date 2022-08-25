class ForumModel {
  String? forumId;
  String? title;
  String? description;
  String? imageUrl;
  String? userId;
  List<ForumLikes>? forumLikes;
  List<ForumComments>? forumComments;
  Publisher? publisher;

  ForumModel.fromJson(Map<String, dynamic> json) {
    forumId = json['forumId'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    userId = json['userId'];
    if (json['ForumLikes'] != null) {
      forumLikes = <ForumLikes>[];
      json['ForumLikes'].forEach((v) {
        forumLikes!.add(ForumLikes.fromJson(v));
      });
    }
    if (json['ForumComments'] != null) {
      forumComments = <ForumComments>[];
      json['ForumComments'].forEach((v) {
        forumComments!.add(ForumComments.fromJson(v));
      });
    }
    if (json['user'] != null) {
      publisher = Publisher.fromJson(json['user']);
    }
  }
}

class ForumLikes {
  String? forumId;
  String? userId;
  ForumLikes({required this.forumId, required this.userId,});
  ForumLikes.fromJson(Map<String, dynamic> json) {
    forumId = json['forumId'];
    userId = json['userId'];
  }
}

class ForumComments {
  String? forumCommentId;
  String? forumId;
  String? userId;
  String? comment;
  DateTime? createdAt;
  ForumComments({required this.userId, required this.forumId, required this.comment, required this.forumCommentId});
  ForumComments.fromJson(Map<String, dynamic> json) {
    forumCommentId = json['forumCommentId'];
    forumId = json['forumId'];
    userId = json['userId'];
    comment = json['comment'];
    createdAt = DateTime.parse(json['createdAt']);
  }
}

class Publisher {
  String? firstName;
  String? lastName;
  String? imageUrl;

  Publisher.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    imageUrl = json['imageUrl'];
  }
}
