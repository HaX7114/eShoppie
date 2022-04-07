import 'package:eshoppie/Models/product.dart';
import 'package:eshoppie/api_handler.dart';
import 'package:flutter/cupertino.dart';

import 'order.dart';

class OrderDetails {
  dynamic id;
  dynamic cost;
  dynamic vat;
  dynamic total;
  dynamic paymentMethod;
  dynamic date;
  dynamic status;
  List<Product>? products;

  OrderDetails(
      {this.id,
      this.cost,
      this.date,
      this.paymentMethod,
      this.status,
      this.total,
      this.vat,
      this.products});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
    date = json['date'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    total = json['total'];
    vat = json['vat'];
    products = setList(json['products']);
  }

  setList(List<dynamic> json) {
    List<Product> products = [];
    for (var element in json) {
      products.add(Product(
        id: element['id'],
        name: element['name'],
        image: element['image'],
        price: element['price'],
        qty: element['quantity'],
      ));
    }
    return products;
  }

  static Future<dynamic> getOrderDetails(
    int id,
  ) async {
    dynamic res = 0;
    OrderDetails o;
    await APIHandler.dio!.get(APIHandler.orders + '/$id').then((value) {
      o = OrderDetails.fromJson(value.data['data']);
      res = o;
      print(o.products![0].id + 'IIIIIIIIIIIIIIIIDDDDDDDDDDDDD');
    }).catchError((error) {
      print(error.toString() + 'EEEEEEEEEEEEEEEEEEEEEEEEEEee');
      //No response error 404
    });
    return res;
  }
}
