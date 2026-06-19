import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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