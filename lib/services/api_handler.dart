import 'dart:convert';

import 'package:flutter_shop_rest/consts/api_consts.dart';
import 'package:flutter_shop_rest/models/product_model.dart';

import 'package:http/http.dart' as http;

import '../models/category.dart';

class APIHandler {
  static Future<List<dynamic>> getData({required String target}) async {
    var url = Uri.https(BASE_URL, '/api/v1/$target');
    //https://api.escuelajs.co/api/v1/products
    var response = await http.get(url);
    //  print(jsonDecode(response.body));
    var data = jsonDecode(response.body);
    List tempList = []; //list of product details
    for (var pro in data) {
      tempList.add(pro);
    }
    return tempList;
  }

  static Future<List<ProductsModel>> getAllProducts() async {
    List temp = await getData(target: 'products');
    return ProductsModel.productfromSnapshot(temp);
  }

  static Future<List<Category>> getAllCategory() async {
    List temp = await getData(target: 'categories');
    return Category.categoryfromSnapshot(temp);
  }
}
