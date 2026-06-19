import 'package:flutter/material.dart';
import '../models/model_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'product_detail_page.dart';

import '../widgets/product_card.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel> products = [];

  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productList = prefs.getStringList('products') ?? [];

    setState(() {
      products = productList
          .map((item) => ProductModel.fromJson(item))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> saveProducts() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> productList = products.map((item) => item.toJson()).toList();

    await prefs.setStringList('products', productList);
  }

  Future<void> addProduct(ProductModel product) async {
    setState(() {
      products.add(product);
    });

    await saveProducts();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produk berhasil ditambahkan")),
    );
  }

  Future<void> updateProduct(int index, ProductModel product) async {
    setState(() {
      products[index] = product;
    });

    await saveProducts();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Produk berhasil diperbarui")));
  }

  Future<void> deleteProduct(int index) async {
    setState(() {
      products.removeAt(index);
    });

    await saveProducts();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Produk berhasil dihapus")));
  }

  void showForm(ProductModel? product, int? index) {
    final formKey = GlobalKey<FormState>();

    TextEditingController nameController = TextEditingController(
      text: product?.name ?? "",
    );

    TextEditingController descriptionController = TextEditingController(
      text: product?.description ?? "",
    );

    TextEditingController priceController = TextEditingController(
      text: product?.price.toString() ?? "",
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(product == null ? "Tambah Produk" : "Edit Produk"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Deskripsi tidak boleh kosong";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Harga",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Harga tidak boleh kosong";
                  }

                  if (int.tryParse(value) == null) {
                    return "Harga harus berupa angka";
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) {
                return;
              }

              final newProduct = ProductModel(
                name: nameController.text.trim(),
                description: descriptionController.text.trim(),
                price: int.parse(priceController.text.trim()),
              );

              if (product == null) {
                addProduct(newProduct);
              } else {
                updateProduct(index!, newProduct);
              }

              Navigator.pop(context);
            },
            child: Text(product == null ? "Simpan" : "Perbarui"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produk", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: products.isEmpty
                  ? const Center(child: Text("Belum ada produk"))
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return ProductCard(
                          product: product,
                          onEdit: () => showForm(product, index),
                          onDelete: () => deleteProduct(index),
                          
                        );

                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showForm(null, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}