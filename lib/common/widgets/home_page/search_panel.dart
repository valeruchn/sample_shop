// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/text_constants.dart';
import 'package:sample_shop/common/helpers/utils/debouncer.dart';
import 'package:sample_shop/store/actions/products.action.dart';
import 'package:sample_shop/store/reducers/reducer.dart';

class _SearchModel {
  _SearchModel({required this.search, required this.resetSearch});

  Function(String searchText) search;
  Function(TextEditingController controller,
      void Function(void Function()) setState) resetSearch;
}

class SearchPanel extends StatefulWidget {
  const SearchPanel({Key? key, required this.searchController})
      : super(key: key);
  final TextEditingController searchController;

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  final _debouncer = Debouncer(milliseconds: 700);

  // Обработка поля поиска
  _SearchModel _searchStateHandler(Store<AppState> store) => _SearchModel(
      search: (String searchText) =>
          store.dispatch(HandleSearchQueryPending(search: searchText)),
      resetSearch: (TextEditingController controller,
          void Function(void Function()) setState) {
        store.dispatch(ResetQueryFiltersPending());
        controller.clear();
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {});
      });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SearchModel>(
      onDispose: (store) {
        if (widget.searchController.text.isEmpty &&
            store.state.products.productsQuery.search != null) {
          store.dispatch(ResetQueryFiltersPending());
        }
      },
      converter: _searchStateHandler,
      builder: (context, handler) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: TextField(
          style: const TextStyle(color: kDefaultTextColor),
          maxLength: 30,
          decoration: InputDecoration(
            label: const Text(kSearchPanelLabelText),
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            counterText: '',
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            suffixIcon: (widget.searchController.text.isNotEmpty)
                ? IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: const Icon(Icons.clear),
                    onPressed: () =>
                        handler.resetSearch(widget.searchController, setState),
                  )
                : null,
          ),
          controller: widget.searchController,
          onChanged: (value) => _debouncer.run(() => handler.search(value)),
        ),
      ),
    );
  }
}
