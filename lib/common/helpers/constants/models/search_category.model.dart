class SearchCategoryModel {
  SearchCategoryModel({required this.title, required this.category});

  final String category;
  final String title;
}

class SearchSubCategoryModel {
  SearchSubCategoryModel(
      {required this.title,
      required this.category,
      required this.subcategory,
      /*required this.subCatTitle*/});

  final String category;
  final String title;
  final String subcategory;
  // final String subCatTitle;
}
