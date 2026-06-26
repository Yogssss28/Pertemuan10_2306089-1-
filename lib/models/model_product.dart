import 'dart:convert';

class ProductModel {
  final String name;
  final String description;
  final int price;
  final String image; // Menambahkan properti image
  
  //constructor
ProductModel({
  required this.name,
  required this.description,
  required this.price,
  required this.image, // Menambahkan parameter image
  });

  // 3. Mengubah Object ke Map (OBJECT -> MAP)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image': image, // Menambahkan properti image
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
      image: map['image'] ?? '', // Menambahkan properti image
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