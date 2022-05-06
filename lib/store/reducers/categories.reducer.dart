// Package imports:
import 'package:redux/redux.dart';
// Project imports:
import 'package:sample_shop/store/actions/categories.action.dart';
import 'package:sample_shop/store/models/categories/category.model.dart';

final Reducer<List<CategoryModel>> categoriesReducer =
    combineReducers<List<CategoryModel>>(<
        List<CategoryModel> Function(List<CategoryModel>, dynamic)>[
  TypedReducer<List<CategoryModel>, GetCategoriesSuccess>(_getCategories),
]);

List<CategoryModel> _getCategories(
    List<CategoryModel> state, GetCategoriesSuccess action) {
  return action.categories;
}
