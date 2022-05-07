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
  } else if (action.favourites != null) {
    return action.favourites!;
  } else if (action.category != null && action.subcategory == null) {
    return action.category!;
  } else if (action.category != null && action.subcategory != null) {
    return action.subcategory!;
  } else {
    return kHomeScreenTitleText;
  }
}
