class OrdersQueryModel {
  OrdersQueryModel(
      {this.page = 1,
      this.isLastPage = false,
      this.isLoading = false,
      this.startDate,
      this.endDate});

  final int page;
  final bool isLastPage;
  final bool isLoading;
  final DateTime? startDate;
  final DateTime? endDate;
}
