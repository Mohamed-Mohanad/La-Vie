import 'package:la_vie_app/models/products/product.dart';

class Plant extends Product {
  Plant.fromJson(Map<String, dynamic> json) {
    id = json['plantId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    waterCapacity = json['waterCapacity'];
    sunLight = json['sunLight'];
    temperature = json['temperature'];
  }
}
