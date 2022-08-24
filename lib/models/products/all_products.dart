import 'package:la_vie_app/models/products/plants.dart';
import 'package:la_vie_app/models/products/seeds.dart';
import 'package:la_vie_app/models/products/tools.dart';

class AllProductsResponse {
  late final String type;
  late final String message;
  late final Products data;

  AllProductsResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = Products.fromJson(json['data']);
  }
}

class Products {
  late final List<Plant> plants;
  late final List<Seed> seeds;
  late final List<Tool> tools;

  Products.fromJson(Map<String, dynamic> json) {
    plants = List.from(json['plants']).map((e) => Plant.fromJson(e)).toList();
    seeds = List.from(json['seeds']).map((e) => Seed.fromJson(e)).toList();
    tools = List.from(json['tools']).map((e) => Tool.fromJson(e)).toList();
  }
}
