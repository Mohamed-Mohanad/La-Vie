import 'package:la_vie_app/models/products/product.dart';

class Tool extends Product {
  Tool.fromJson(Map<String, dynamic> json) {
    id = json['toolId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }
}
