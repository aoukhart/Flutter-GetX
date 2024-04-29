import 'package:http/http.dart';
import 'dart:convert';

class Product{
  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discount,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail
  });
  
  int    ?id;
  String ?title;
  String ?description;
  int    ?price;
  double ?discount;
  dynamic rating;
  int    ?stock;
  String ?brand;
  String ?category;
  String ?thumbnail;

  factory Product.fromJson(Map<String, dynamic> json){
    // print(json);
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discount: json['discountPercentage'],
      rating: json['rating'],
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail']);
  }
}

  Future<List<Product>> getProducts() async{
    // var client = http.Client();
    var response = await get(Uri.parse('https://dummyjson.com/products'));
    // print(response.body);
    return List<Product>.from(json.decode(response.body)['products'].map(
      (elem) => Product.fromJson(elem)));

  }
