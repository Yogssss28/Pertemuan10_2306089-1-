import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/model_product.dart';


class ProductDetailPage extends StatelessWidget {
  //variabel data produk yg dipilih
  final ProductModel product;

  // constractor
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Produk")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.image.isNotEmpty
                ? Image.memory(
                    base64Decode(product.image),
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.contain,
                  ) // Image.memory
                : const Icon(Icons.image, size: 250),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Rp ${product.price}"),
            const SizedBox(height: 10),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}