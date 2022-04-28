// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

//Project imports:
import 'package:sample_shop/store/models/cart/cart_query.model.dart';

// Товары в локальном хранилище сохраняются в виде массива строк
// В формате 'productId/count' . После чего при анализе строка
// разбивается по разделителю '/' и обрабатывается

// Получение товаров из хранилища в формате для запроса на api
Future<List<CartQueryModel>> getProductsFromLocalStorage() async {
  // Подключаемся к хранилищу
  final prefs = await SharedPreferences.getInstance();
  // Получаем массив строк из хранилища
  final List<String>? items = prefs.getStringList('products');
  // возвращаем результат
  if (items != null) {
    return _getCartFromLocalStorage(items);
  }
  return [];
}

// Добавление елемента в корзину
Future<dynamic> addCartItemsInAsyncStorage(CartQueryModel newProduct) async {
  // Подключаемся к хранилищу
  final prefs = await SharedPreferences.getInstance();
  // Получаем массив строк из хранилища
  final List<String>? items = prefs.getStringList('products');
  if (items != null) {
    bool _itemInStorage = false;
    List<CartQueryModel> checkCart =
        _getCartFromLocalStorage(items).map((productInCart) {
      if (productInCart.id == newProduct.id) {
        // если товар в корзине меняем на true и прибавляем количество
        _itemInStorage = true;
        return CartQueryModel(
            id: productInCart.id,
            count: productInCart.count + newProduct.count);
      } else {
        return productInCart;
      }
    }).toList();
    // Добавляем в хранилище либо новый товар либо его количество
    if (_itemInStorage) {
      return await prefs.setStringList(
          'products', _convertCartToStringArray(checkCart));
    } else {
      return await prefs.setStringList(
          'products', _convertCartToStringArray([...checkCart, newProduct]));
    }
  } else {
    // если в корзине ничего не было создаем запись
    return await prefs.setStringList(
        'products', _convertCartToStringArray([newProduct]));
  }
}

// Удаление елемента из корзины
Future<dynamic> deleteItemFromCartInAsyncStorage(String id) async {
  // Подключаемся к хранилищу
  final prefs = await SharedPreferences.getInstance();
  // Получаем массив строк из хранилища
  final List<String>? items = prefs.getStringList('products');
  if (items != null) {
    List<String> result = _convertCartToStringArray(
        _getCartFromLocalStorage(items).where((i) => i.id != id).toList());
    return await prefs.setStringList('products', result);
  }
}

// Уменьшение количества товара в корзине
Future<dynamic> decrementCartItemsInAsyncStorage(
    String id) async {
  // Подключаемся к хранилищу
  final prefs = await SharedPreferences.getInstance();
  // Получаем массив строк из хранилища
  final List<String>? items = prefs.getStringList('products');
  if (items != null) {
    bool _itemInStorage = false;
    List<CartQueryModel> checkCart =
        _getCartFromLocalStorage(items).map((productInCart) {
      if (productInCart.id == id && productInCart.count > 1) {
        // если товар в корзине и при отнимании его останется больше 1 меняем на true и отнимаем
        _itemInStorage = true;
        return CartQueryModel(
            id: productInCart.id,
            count: productInCart.count - 1);
      } else {
        return productInCart;
      }
    }).toList();
    // делаем запись в хранилище, либо уменьшенное количество товара, либо корзина без него
    if (_itemInStorage) {
      return await prefs.setStringList(
          'products', _convertCartToStringArray(checkCart));
    } else {
      return await prefs.setStringList(
          'products',
          _convertCartToStringArray(
              checkCart.where((i) => i.id != id).toList()));
    }
  }
}

// Преобразовать массив строк из хранилища в обьекты
List<CartQueryModel> _getCartFromLocalStorage(List<String> items) {
  return items.map((item) {
    List<String> cartItem = item.split('/');
    return CartQueryModel(id: cartItem[0], count: int.parse(cartItem[1]));
  }).toList();
}

// реобразовать обьект корзины в массив строк для сохранения в хранилище
List<String> _convertCartToStringArray(List<CartQueryModel> cart) {
  return cart.map((item) => '${item.id}/${item.count}').toList();
}

// Очистка корзины
Future clearCartFromAsyncStorage() async{
  // Подключаемся к хранилищу
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('products');
}
