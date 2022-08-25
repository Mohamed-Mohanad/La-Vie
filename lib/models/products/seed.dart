import 'package:la_vie_app/models/products/product.dart';

class Seed extends Product {
  Seed.fromJson(Map<String, dynamic> json) {
    id = json['seedId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }
}
