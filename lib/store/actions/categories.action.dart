// Project imports:
import 'package:sample_shop/store/models/categories/category.model.dart';

class GetCategoriesPending {}

class GetCategoriesSuccess {
  GetCategoriesSuccess({required this.categories});

  List<CategoryModel> categories;
}
