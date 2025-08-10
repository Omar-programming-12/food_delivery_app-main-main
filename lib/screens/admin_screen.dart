import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '/services/product_admin_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final ProductAdminService _productService = ProductAdminService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  XFile? _pickedImage;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = picked;
      });
    }
  }

  void _showAddProductModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add Product",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: _pickImage,
                  child: _pickedImage != null
                      ? Image.file(File(_pickedImage!.path),
                          height: 120, fit: BoxFit.cover)
                      : Container(
                          height: 120,
                          color: Colors.grey[300],
                          child: Icon(Icons.camera_alt, size: 40),
                        ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Price"),
                ),
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: "Category"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final name = _nameController.text.trim();
                    final desc = _descriptionController.text.trim();
                    final price = double.tryParse(_priceController.text.trim()) ?? 0;
                    final category = _categoryController.text.trim();

                    if (name.isEmpty || desc.isEmpty || price <= 0 || category.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill all fields")),
                      );
                      return;
                    }

                    try {
                      await _productService.addProduct(
                        name: name,
                        description: desc,
                        price: price,
                        category: category,
                        image: _pickedImage,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Product added successfully")),
                      );

                      _nameController.clear();
                      _descriptionController.clear();
                      _priceController.clear();
                      _categoryController.clear();
                      setState(() => _pickedImage = null);

                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: $e")),
                      );
                    }
                  },
                  child: Text("Add"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productService.getProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!.docs;

          if (products.isEmpty) {
            return Center(child: Text("No products found"));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final data = products[index].data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: data['imageUrl'] != null && (data['imageUrl'] as String).isNotEmpty
                      ? Image.network(data['imageUrl'],
                          width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.image, size: 40),
                  title: Text(data['name'] ?? ''),
                  subtitle: Text("\$${data['price']} - ${data['category']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await _productService.deleteProduct(products[index].id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductModal,
        child: Icon(Icons.add),
      ),
    );
  }
}
