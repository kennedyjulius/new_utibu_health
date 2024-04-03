import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));
String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.quantity,
    this.location,
  });

  String image;
  String id;
  String name;
  double price;
  String description;
  int? quantity;
  String? location;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    image: json["image"],
    id: json["productId"].toString(),
    name: json["name"],
    price: double.parse(json["price"]),
    description: json["description"],
    quantity: json["quantity"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "productId": id,
    "name": name,
    "price": price.toString(),
    "description": description,
    "quantity": quantity,
    "location": location,
  };

  ProductModel copyWith({
    String? image,
    String? id,
    String? name,
    double? price,
    String? description,
    int? quantity,
    String? location,
  }) {
    return ProductModel(
      image: image ?? this.image,
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      location: location ?? this.location,
    );
  }
}