import 'package:flutter/material.dart';
import 'package:tv_shedule/data/schedule.dart';
import 'package:tv_shedule/utils/api_result.dart';
import 'package:tv_shedule/utils/result.dart';

abstract class ScheduleRepository extends ChangeNotifier{
  Future<ApiResult<ScheduleDto>> onGetScheduleByNetwork();
  Future<Result<ScheduleDto>> onGetScheduleFromDisk(String path);
}