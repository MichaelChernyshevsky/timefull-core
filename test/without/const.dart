import 'dart:io';

import 'package:timefullcore/model.dart';

CoreModel get coreModelWithout => CoreModel(loggined: false, internet: false, userId: '');

Future<String> get testDirectory async => (await Directory.systemTemp.createTemp('/')).path;
