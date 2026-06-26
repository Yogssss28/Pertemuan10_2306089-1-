import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pertemuan10_2306034/models/model_product.dart';
import 'package:pertemuan10_2306034/pages/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
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

        // icon edit hanya muncul kalau onEdit a

        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            product.image.isNotEmpty
                ? Image.memory(
                    base64Decode(product.image),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ) // Image.memory
                : const Icon(Icons.image, size: 120),
            const SizedBox(height: 5),
            Text("Rp ${product.price}"),
            const SizedBox(height: 5),
            Text(product.description),
          ],
        ),

        // icon hapus hanya muncul kalau onDelete ada
       trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onEdit != null)
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.orange),
                onPressed: onEdit,
              ),
            const SizedBox(width: 8),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
          ],
        ),      // tutup Row
      ),        // tutup ListTile
    );          // tutup Card
  }
}