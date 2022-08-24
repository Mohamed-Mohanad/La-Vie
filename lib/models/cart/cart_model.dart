class CartModel {
  String? id;
  String? name;
  int? quantity;
  String? imageUrl;
  double? price;

  CartModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.imageUrl,
    this.price = 200,
  });

  CartModel.fromDB(Map<String, dynamic> db) {
    id = db['product_id'];
    name = db['name'];
    quantity = db['quantity'];
    imageUrl = db['image_url'];
    price = 200.0;
  }
}
