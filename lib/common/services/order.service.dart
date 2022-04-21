// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:sample_shop/store/models/order/current_order.model.dart';

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
