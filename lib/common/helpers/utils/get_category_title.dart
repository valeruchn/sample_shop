import 'package:sample_shop/store/models/categories/category.model.dart';

// Получение заголовка категории, спользуется в products epics
String? getCategoryTitle(
    {required List<CategoryModel> categories,
    String? category,
    String? subcategory}) {
  if (category == null) {
    return null;
  }
  // Получение текущей категории из state
  CategoryModel currentCategory =
      categories.firstWhere((element) => element.category == category);
  // Если передана подкатегория - возвращаем ее заголовок
  if (subcategory != null && subcategory != '') {
    return currentCategory.subcategories
        .firstWhere((element) => element.subcategory == subcategory)
        .subcategory_title;
  } else {
    // Если подкатегория не передана, возвращаем заголовок категории
    return currentCategory.title;
  }
}
