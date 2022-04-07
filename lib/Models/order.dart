import 'package:eshoppie/Shared/shared_preference.dart';
import 'package:eshoppie/api_handler.dart';

class Order {
  dynamic id;
  dynamic total;
  dynamic date;
  dynamic status;

  Order({this.id, this.total, this.date, this.status});

  Order.fromJson(List<dynamic> savedOrders, List<Order> orders) {
    for (var element in savedOrders) {
      orders.add(
        Order(
            id: element['id'],
            date: element['date'],
            status: element['status'],
            total: element['total']),
      );
    }
  }

  static Future<bool> setOrder(int paymentMethod) async {
    bool status = false;
    dynamic addressID =
        SharedHandler.getSharedPref(SharedHandler.saveAddressIDKey);

    await APIHandler.dio!.post(
      APIHandler.orders,
      data: {
        "address_id": addressID,
        "payment_method": paymentMethod,
        "use_points": false
      },
    ).then((value) {
      status = value.data['status'];
    }).catchError((error) {
      status = false;
    });
    return status;
  }

  static Future<int> getAllOrders(List<Order> orders) async {
    int result = 0;
    await APIHandler.dio!.get(APIHandler.orders).then((value) {
      if (value.data['data']['data'].isEmpty) {
        result = 0; //Zero stands for empty list
      } else {
        Order.fromJson(value.data['data']['data'], orders);
        result = 1; //1 stands for a list with data
      }
    }).catchError((error) {
      print('EEEEEEEEEEEEEEEEEEEEEE' + error.toString());
      result = 2; //2 stands for an error occurred
      //No response error 404
    });
    return result;
  }
}
