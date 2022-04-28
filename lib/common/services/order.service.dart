// Import the firebase_core and cloud_firestore plugin
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:sample_shop/common/helpers/api/app_api.dart';

// Project imports:
import 'package:sample_shop/store/models/order/current_order.model.dart';
import 'package:sample_shop/store/models/order/create_order_dto.model.dart';

// Create a CollectionReference called orders that references the firestore collection
CollectionReference orders = FirebaseFirestore.instance.collection('orders');

Future<CurrentOrderModel> addOrder(CurrentOrderModel order) {
  // Отправляем обьект в формате JSON
  return orders
      .add(order.toJson())
      // Получаем id созданного документа и по нему возвращаем результат
      .then((value) => orders.doc(value.id).get())
      // озвращаем обьект, полученный из JSON
      .then((data) =>
          CurrentOrderModel.fromJson(data.data() as Map<String, dynamic>))
      .catchError((error) => print("Failed to add order: $error"));
}

// Создание заказа
Future<CurrentOrderModel> createNewOrder(CreateOrderDtoModel order) async {
  try {
    final Response<dynamic> res = await api.post('/orders/create', data: order);
    final Map<String, dynamic> createdOrder = res.data as Map<String, dynamic>;
    return CurrentOrderModel.fromJson(createdOrder);
  } catch(e) {
    print('service error: $e');
  }
  return null as CurrentOrderModel;
}

// Future<List<CurrentOrderModel>> getOrdersLog() {
//
// }
