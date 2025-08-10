import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // رفع الصورة وإرجاع رابطها
  Future<String> uploadImage(XFile image) async {
    final file = File(image.path);
    final ref = _storage
        .ref()
        .child('products/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  // إضافة منتج جديد
  Future<void> addProduct({
    required String name,
    required String description,
    required double price,
    required String category,
    XFile? image,
  }) async {
    String imageUrl = '';
    if (image != null) {
      imageUrl = await uploadImage(image);
    }

    await _firestore.collection('products').add({
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // جلب المنتجات في Stream
  Stream<QuerySnapshot> getProductsStream() {
    return _firestore.collection('products').orderBy('createdAt', descending: true).snapshots();
  }

  // حذف منتج
  Future<void> deleteProduct(String id) async {
    await _firestore.collection('products').doc(id).delete();
  }
}
