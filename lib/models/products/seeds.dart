class Seeds {
  late final String type;
  late final String message;
  late final List<Seed> data;

  Seeds.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Seed.fromJson(e)).toList();
  }
}

class Seed {
  late final String seedId;
  late final String name;
  late final String description;
  late final String imageUrl;

  Seed.fromJson(Map<String, dynamic> json) {
    seedId = json['seedId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }
}
