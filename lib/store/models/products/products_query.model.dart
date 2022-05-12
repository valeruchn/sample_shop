class ProductQueryModel {
  const ProductQueryModel(
      {this.category,
      this.subcategory,
      this.search,
      this.favourites = false,
      this.page = 1,
      this.isLoad = false,
      this.isLastPage = false});

  final String? category;
  final String? subcategory;
  final String? search;
  final bool isLoad;
  final int page;
  final bool favourites;
  final bool isLastPage;
}
