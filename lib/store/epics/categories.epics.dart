// Package imports:
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:sample_shop/common/services/categories.service.dart';
import 'package:sample_shop/store/actions/categories.action.dart';
import 'package:sample_shop/store/models/categories/category.model.dart';

Stream<void> getCategoriesEpic(Stream actions, EpicStore store) {
  return actions.where((action) => action is GetCategoriesPending).switchMap(
      (action) => Stream<List<CategoryModel>>.fromFuture(getCategories())
          .expand((List<CategoryModel> categories) =>
              [GetCategoriesSuccess(categories: categories)])
          .handleError((e) => {print('error get categories epic: $e')}));
}
