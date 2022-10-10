import 'package:flutter/cupertino.dart';

class Category with ChangeNotifier {
  int? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }

  static List<Category> categoryfromSnapshot(List categorySnapshot) {
    //  print('data: ${productSnapshot[0]}');
    return categorySnapshot.map((data) => Category.fromJson(data)).toList();
  }
}
