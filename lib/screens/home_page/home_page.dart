// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
// Project imports:
import 'package:sample_shop/store/reducers/reducer.dart';
import 'package:sample_shop/screens/home_page/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      // Для получения данных из стейт
      body: Container(
        color: Colors.black,
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) => GridView.count(
            // сохранение состояния скрола при переключении на другой скрин
            key: const PageStorageKey('products list'),
            primary: false,
            padding: const EdgeInsets.all(7),
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 2,
            // соотношение сторон ячеек грид сетки
            childAspectRatio: (1 / 1.5),
            children: state.products.isNotEmpty
                ? [
                    ...state.products
                        .map((product) => Container(
                              child: ProductCard(
                                id: product.id,
                                title: product.title,
                                property: product.property,
                                weight: product.weight,
                                description: product.description,
                                photo: product.photo,
                                category: product.category,
                                price: product.price,
                              ),
                            ))
                        .toList(),
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}
