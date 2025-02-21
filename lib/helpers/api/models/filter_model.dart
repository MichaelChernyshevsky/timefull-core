class FilterRequestModel {
  final int dateFrom;
  final int dateTo;
  final int page;
  final int countOnPage;

  FilterRequestModel({
    required this.dateFrom,
    required this.dateTo,
    required this.page,
    required this.countOnPage,
  });
}
