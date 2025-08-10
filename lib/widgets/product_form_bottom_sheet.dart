import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/product_service.dart';

class ProductFormBottomSheet extends StatefulWidget {
  final String? productId;
  final Map<String,dynamic>? existingData;

  const ProductFormBottomSheet({super.key, this.productId, this.existingData});

  @override
  State<ProductFormBottomSheet> createState() => _ProductFormBottomSheetState();
}

class _ProductFormBottomSheetState extends State<ProductFormBottomSheet> {
  final ProductService _productService = ProductService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if(widget.existingData != null){
      _nameController.text = widget.existingData!['name'] ?? '';
      _descController.text = widget.existingData!['description'] ?? '';
      _priceController.text = widget.existingData!['price'] ?? '';
      _imageUrlController.text = widget.existingData!['imageUrl'] ?? '';
    }
  }
  void _saveProduct() async {
    if(_formKey.currentState!.validate()){
      final productData = {
        'name': _nameController.text,
        'description': _descController.text,
        'price': double.tryParse(_priceController.text) ?? 0,
        'imageUrl': _imageUrlController.text,
        'category': 'Burger'
      };
      if(widget.productId == null){
        await _productService.addProduct(productData);
      } else{
        await _productService.updateProduct(widget.productId!, productData);
      }
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Enter Description' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct, 
                child: Text(widget.productId == null ? 'Add Product' : 'Update Product')
              ),
            ],
          ),
        ),
      ),
    );
  }
}