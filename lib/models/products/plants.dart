class Plants {
  late final String type;
  late final String message;
  late final List<Plant> data;

  Plants.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Plant.fromJson(e)).toList();
  }
}

class Plant {
  late final String plantId;
  late final String name;
  late final String description;
  late final String imageUrl;
  late final int waterCapacity;
  late final int sunLight;
  late final int temperature;

  Plant.fromJson(Map<String, dynamic> json) {
    plantId = json['plantId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    waterCapacity = json['waterCapacity'];
    sunLight = json['sunLight'];
    temperature = json['temperature'];
  }
}
