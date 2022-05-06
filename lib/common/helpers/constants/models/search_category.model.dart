class SearchCategoryModel {
  SearchCategoryModel({required this.title, required this.category});

  final String category;
  final String title;
}

class SearchSubCategoryModel {
  SearchSubCategoryModel(
      {required this.title,
      required this.category,
      required this.subcategory});

  final String category;
  final String title;
  final String subcategory;
}
