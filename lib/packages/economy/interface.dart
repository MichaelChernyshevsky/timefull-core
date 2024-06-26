abstract class EconomyInterface {
  void addEconomyApi({
    required String title,
    required String description,
    required int count,
    required int date,
    required int income,
    required String userId,
  }) {}
  void deleteEconomyApi({required String id, required String userId}) {}
  void getEconomyApi({required String userId}) {}
  void statEconomyApi() {}
}
