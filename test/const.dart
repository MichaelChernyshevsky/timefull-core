import 'dart:io';

import 'package:timefullcore/helpers/api/models/filter_model.dart';
import 'package:timefullcore/model.dart';

CoreModel get coreModelWithout => CoreModel(
      loggined: false,
      internet: false,
      userId: '',
      isWeb: false,
    );
CoreModel get coreModelWith => CoreModel(
      loggined: true,
      internet: true,
      userId: '26',
      isWeb: false,
    );

Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;

FilterRequestModel get filter => FilterRequestModel(dateFrom: 0, dateTo: 17299764000000, page: 1, countOnPage: 100);
