import 'package:flutter/foundation.dart';

class Category {
  dynamic categoryID;
  dynamic categoryName;
  dynamic categoryImage;

  Category({this.categoryID, this.categoryName, this.categoryImage});

  Category.fromJson(List data, List<Category> categoriesList) {
    data.forEach((element) {
      categoriesList.add(Category(
        categoryID: element['id'],
        categoryName: element['name'],
        categoryImage: element['image'],
      ));
    });
  }
}
