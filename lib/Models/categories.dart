class Category {
  dynamic categoryID;
  dynamic categoryName;
  dynamic categoryImage;

  Category({this.categoryID, this.categoryName, this.categoryImage});

  Category.fromJson(List data, List<Category> categoriesList) {
    for (var element in data) {
      categoriesList.add(Category(
        categoryID: element['id'],
        categoryName: element['name'],
        categoryImage: element['image'],
      ));
    }
  }
}
