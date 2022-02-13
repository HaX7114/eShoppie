class Product {
  dynamic id;
  dynamic price;
  dynamic image;
  dynamic name;
  dynamic description;
  dynamic images;
  dynamic inFavorites;
  dynamic inCart;

  Product(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.images,
      this.inCart,
      this.inFavorites,
      this.price});

  Product.fromJson(List<dynamic> data, List<Product> products) {
    data.forEach((element) {
      products.add(Product(
        id: element['id'],
        description: element['description'],
        image: element['image'],
        images: element['images'],
        inCart: element['in_cart'],
        inFavorites: element['in_favorites'],
        name: element['name'],
        price: element['price'],
      ));
    });
  }

  Product.fromFavorites(List<dynamic> data, List<Product> products) {
    data.forEach((element) {
      if (element['in_favorites']) {
        products.add(Product(
          id: element['id'],
          description: element['description'],
          image: element['image'],
          images: element['images'],
          inCart: element['in_cart'],
          inFavorites: element['in_favorites'],
          name: element['name'],
          price: element['price'],
        ));
      }
    });
  }
}
