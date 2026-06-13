import 'dart:convert';

class ProductModel {
  final String name;
  final String description;
  final int price;
  //constructor
ProductModel({
  required this.name,
  required this.description,
  required this.price,
  });

  // 3. Mengubah Object ke Map (OBJECT -> MAP)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
    };
  }

  // 4. Mengubah dari Map ke Object (MAP -> OBJECT)
  factory ProductModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ProductModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
    );
  }

// JSON STRING -> OBJECT
  factory ProductModel.fromJson(String source) {
    return ProductModel.fromMap(
      jsonDecode(source),
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}


