import 'dart:convert';
import 'dart:io';

import 'package:tv_shedule/data/repository/schedule_repository.dart';
import 'package:tv_shedule/data/schedule.dart';
import 'package:tv_shedule/network/api/main_api.dart';
import 'package:tv_shedule/utils/api_result.dart';
import 'package:tv_shedule/utils/result.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final MainApi api;

  ScheduleRepositoryImpl({required this.api});

  @override
  Future<ApiResult<ScheduleDto>> onGetScheduleByNetwork() async {
    return await api.getSchedule();
  }

  @override
  Future<Result<ScheduleDto>> onGetScheduleFromDisk(String path) async {
    try {
      File file = File(path);
      final String content = await file.readAsString();
      final Map<String, dynamic> js = jsonDecode(content);
      final schedule = ScheduleDto.fromJson(js);

      return Result.ok(schedule);
    } on Exception catch (e){
      return Result.error(e);
    }
  }
}