class Product {
  dynamic id;
  dynamic price;
  dynamic image;
  dynamic name;
  dynamic description;
  dynamic images;
  dynamic inFavorites;
  dynamic inCart;
  dynamic qty;

  Product(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.images,
      this.inCart,
      this.inFavorites,
      this.price,
      this.qty});

  Product.fromJson(List<dynamic> data, List<Product> products) {
    for (var element in data) {
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
  }

  Product.fromProductDetails(List<dynamic> data, List<Product> products) {
    for (var element in data) {
      products.add(Product(
        id: element['id'],
        image: element['image'],
        qty: element['quantity'],
        name: element['name'],
        price: element['price'],
      ));
    }
  }

  Product.fromFavorites(List<dynamic> data, List<Product> products) {
    for (var element in data) {
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
    }
  }

  Product.fromCarts(List<dynamic> data, List<Product> products) {
    for (var element in data) {
      if (element['in_cart']) {
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
    }
  }
}
