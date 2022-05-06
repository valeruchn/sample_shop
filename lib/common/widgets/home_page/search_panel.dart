import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample_shop/common/helpers/utils/debouncer.dart';
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({Key? key}) : super(key: key);

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  final TextEditingController _searchString = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 700);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      // запрашиваем продукты при инициализации виджета, для
      // корректной работы при открытии и закрытии поиска
      onInit: (store) => store.dispatch(GetProductsPending()),
      converter: (store) => (String searchText) =>
          store.dispatch(GetProductsPending(search: searchText)),
      builder: (context, search) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              label: const Text('Пошук'),
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor))),
          controller: _searchString,
          onChanged: (value) => _debouncer.run(() => search(value)),
        ),
      ),
    );
  }
}
