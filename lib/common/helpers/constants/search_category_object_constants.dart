// Project imports:
import 'package:sample_shop/common/helpers/constants/models/search_category.model.dart';
import 'package:sample_shop/common/helpers/constants/text_constants.dart';

// Категории:
final kPizzaCategorySearch = SearchCategoryModel(
    title: kPizzaCategoryTitleText, category: kPizzaCategorySearchText);
// final kRollsCategorySearch = SearchCategoryModel(
//     title: kRollsCategoryTitleText, category: kRollsCategorySearchText);
final kSetsCategorySearch = SearchCategoryModel(
    title: kSetsCategoryTitleText, category: kSetsCategorySearchText);
final kFavouriteCategorySearch = SearchCategoryModel(
    title: kFavouriteCategoryTitleText, category: kFavouriteCategorySearchText);
final kAllCategorySearch = SearchCategoryModel(
    title: kAllCategoryTitleText, category: kAllCategoryTitleSearchText);

// Подкатегории роллов:

// Філадельфія
final kPhiladelphiaSubCatSearch = SearchSubCategoryModel(
    title: kPhiladelphiaSubCatTitleText,
    category: kRollsCategorySearchText,
    subcategory: kPhiladelphiaSubCatSearchText);
// Каліфорнія
final kCaliforniaSubCatSearch = SearchSubCategoryModel(
    title: kCaliforniaSubCatTitleText,
    category: kRollsCategorySearchText,
    subcategory: kCaliforniaSubCatSearchText);
// Смажені
final kFriedSubCatSearch = SearchSubCategoryModel(
    title: kFriedSubCatTitleText,
    category: kRollsCategorySearchText,
    subcategory: kFriedSubCatSearchText);
// Запечені
final kBakedSubCatSearch = SearchSubCategoryModel(
    title: kBakedSubCatTitleText,
    category: kRollsCategorySearchText,
    subcategory: kBakedSubCatSearchText);
// Брендові
final kBrandedSubCatSearch = SearchSubCategoryModel(
    title: kBrandedSubCatTitleText,
    category: kRollsCategorySearchText,
    subcategory: kBrandedSubCatSearchText);
// Макі
final kMakiSubCatSearch = SearchSubCategoryModel(
    title: kMakiSubCatTitleText,
    category: kRollsCategorySearchText,
    subcategory: kMakiSubCatSearchText);
// Всі
final kAllRollsSubCatSearch = SearchSubCategoryModel(
    title: kAllRollsSubCatTitleText,
    category: kRollsCategorySearchText,
    subcategory: '');

//DropDownButton Subcategory menu
final List<SearchSubCategoryModel> kDropDownButtonSubcategoryList = [
  kAllRollsSubCatSearch,
  kPhiladelphiaSubCatSearch,
  kCaliforniaSubCatSearch,
  kFriedSubCatSearch,
  kBakedSubCatSearch,
  kBrandedSubCatSearch,
  kMakiSubCatSearch,
];
