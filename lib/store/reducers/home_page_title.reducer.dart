// Package imports:
import 'package:redux/redux.dart';
// Project imports:
import 'package:sample_shop/store/actions/home_page_title.action.dart';

final Reducer<String> homePageTitleReducer =
combineReducers<String>(<
    String Function(String, dynamic)>[
  TypedReducer<String, SetHomePageTitleSuccess>(_setHomePageTitle),
]);

String _setHomePageTitle(
    String state, SetHomePageTitleSuccess action) {
  return action.homePageTitle;
}