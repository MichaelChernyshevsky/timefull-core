import 'package:timefullcore/helpers/common/repository.dart';
import 'package:timefullcore/helpers/common/stateRepository.dart';
import 'package:timefullcore/packages/economy/model.dart';
import 'package:timefullcore/packages/economy/uri.dart';

class EconomyRepository {
  final HttpService httpService;

  EconomyRepository({required this.httpService});

  Future<RepositoryStat> addEconomyApi({
    required String title,
    required String description,
    required int count,
    required int date,
    required int income,
    required String userId,
  }) async {
    final BaseResponse resp = await httpService.post(economyAdd, data: {
      "userId": userId,
      "count": count,
      "date": date,
      "income": income,
      "title": title,
      "description": description,
    });
    return getStat(resp.message);
  }

  Future<RepositoryStat> deleteEconomyApi({
    required String id,
    required String userId,
  }) async {
    final BaseResponse resp = await httpService.delete(economyDelete, data: {"id": id, 'userId': userId});
    return getStat(resp.message);
  }

  Future<List<EconomyModel>> getEconomyApi({
    required String userId,
  }) async {
    final BaseResponse resp = await httpService.post(economyGet, data: {"userId": userId});
    final List<EconomyModel> models = [];
    for (final element in resp.data['data']) {
      models.add(EconomyModel.fromJson(element));
    }
    return models;
  }

  Future<void> statEconomyApi() async {
    // Implement your API logic here
  }

  Future<void> wipeEconomyApi({
    required String userId,
    required bool loggined,
    required bool internet,
  }) async {
    // Implement your API logic here
  }
}
