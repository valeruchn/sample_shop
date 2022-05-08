// Package imports:
import 'package:redux/redux.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';

// Project imports:
import 'package:sample_shop/store/actions/home_page_title.action.dart';

final Reducer<String> homePageTitleReducer =
    combineReducers<String>(<String Function(String, dynamic)>[
  TypedReducer<String, SetHomePageTitleSuccess>(_setHomePageTitle),
]);

String _setHomePageTitle(String state, SetHomePageTitleSuccess action) {
  if (action.search != null) {
    return kSearchPanelLabelText;
  } else if (action.favourites) {
    return kFavouriteCategoryTitleText;
  } else if (action.category != null) {
    return action.category!;
  } else {
    return kHomeScreenTitleText;
  }
}
