
import 'package:tv_shedule/data/schedule.dart';
import 'package:tv_shedule/utils/api_result.dart';
import 'package:tv_shedule/utils/http_util.dart';

class MainApi {
  HttpUtil httpUtil = HttpUtil();

  Future<ApiResult<ScheduleDto>> getSchedule() async {
    try {
      final response = await httpUtil.get("get_schedule/");
      final data = ScheduleDto.fromJson(response);
      return ApiResult.success(data);
    } on Exception catch (e){
      return ApiResult.failure(e);
    }
  }
}