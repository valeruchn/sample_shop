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

// Добавление заказа в firestore
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

// Создание заказа в основном api
Future<CurrentOrderModel> createNewOrder(CreateOrderDtoModel order) async {
  try {
    final Response<dynamic> res = await api.dio.post('/orders/create', data: order);
    final Map<String, dynamic> createdOrder = res.data as Map<String, dynamic>;
    return CurrentOrderModel.fromJson(createdOrder);
  } catch (e) {
    print('create order error: $e');
  }
  return null as CurrentOrderModel;
}

Future<List<CurrentOrderModel>> getOrdersLog() async {
  try {
    final Response<dynamic> res = await api.dio.get('/orders');
    final List<dynamic> getOrdersResult = res.data as List<dynamic>;
    return getOrdersResult
        .map<CurrentOrderModel>((order) =>
            CurrentOrderModel.fromJson(order as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('get orders log error: $e');
  }
  return [];
}

Future<CurrentOrderModel> getCurrentOrder(String orderId) async {
  try {
    final Response<dynamic> res = await api.dio.get('/orders/get-order/$orderId');
    final Map<String, dynamic> getCurrentOrderResult = res.data;
    return CurrentOrderModel.fromJson(getCurrentOrderResult);
  } catch (e) {
    print('get current order error: $e');
  }
  return null as CurrentOrderModel;
}
