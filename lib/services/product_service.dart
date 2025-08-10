import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService{

  final CollectionReference _products = 

  FirebaseFirestore.instance.collection('products');
  
   Future<void> addProduct(Map<String, dynamic > productData) async {
  await FirebaseFirestore.instance.collection('products').add(productData);
 }

 Future<void> updateProduct(String docId, Map<String , dynamic> newData) async {
  await _products.doc(docId).update(newData);
 }


 Future<void> deleteProduct(String docId) async {
  await _products.doc(docId).delete();
 }


 Stream<QuerySnapshot> getProductsStream(){
  return _products.snapshots();
 }

 
}