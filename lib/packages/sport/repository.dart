import 'package:timefullcore/helpers/api/models/filter_model.dart';
import 'package:timefullcore/packages/sport/uri.dart';
import 'package:timefullcore/core.dart';

class SportRepository {
  final HttpService httpService;

  SportRepository({required this.httpService});

  Future<void> add({
    required String userId,
    required String title,
    required int distant,
    required String date,
  }) async {
    final BaseResponse resp = await httpService.post(sportAddUri, data: {
      'userId': userId,
      'title': title,
      'distant': distant,
      'date': date,
    });
    return resp.message == MESSAGE_SUCCESS ? null : null;
  }

  Future<void> delete({required String userId, required int id}) async {
    final BaseResponse resp = await httpService.delete(sportDeleteUri, data: {
      'userId': userId,
      'id': id,
    });
    return resp.message == MESSAGE_SUCCESS ? null : null;
  }

  Future<BaseResponse> get({
    required String userId,
    required FilterRequestModel filter,
  }) async =>
      httpService.post(sportGetUri, data: {
        'userId': userId,
        'dateFrom': filter.dateFrom,
        'dateTo': filter.dateTo,
        'page': filter.page,
        'countOnPage': filter.countOnPage,
      });
}
