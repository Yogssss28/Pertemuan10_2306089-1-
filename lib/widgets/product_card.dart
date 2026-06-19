import 'package:flutter/material.dart';
import 'package:pertemuan10_2306034/models/model_product.dart';
import 'package:pertemuan10_2306034/pages/product_detail_page.dart';


// ignore: prefer_typing_uninitialized_variables
class ProductCard extends StatelessWidget {
  // membuat variable dari parameter product
  final ProductModel product;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  // constructor untuk memanggil parameter
  const ProductCard({
    super.key,
    required this.product,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailPage(product: product),
            ),
          );
        },
        leading: IconButton(
          icon: const Icon(Icons.edit, color: Colors.orange),
          onPressed: () => onEdit?.call(),
        ),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text("Rp ${product.price}"),
            const SizedBox(height: 5),
            Text(product.description),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => onDelete?.call(),
        ),
      ),
    );
  }
}
