import 'package:flutter/material.dart';

import 'category.dart';

class ProductsModel with ChangeNotifier {
  int? id;
  String? title;
  int? price;
  String? description;
  Category? category;
  List<String>? images;

  ProductsModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.images});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }

  static List<ProductsModel> productfromSnapshot(List productSnapshot) {
    //  print('data: ${productSnapshot[0]}');
    return productSnapshot.map((data) => ProductsModel.fromJson(data)).toList();
  }
}
