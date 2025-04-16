import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tv_shedule/data/repository/schedule_repository_impl.dart';
import 'package:tv_shedule/network/api/main_api.dart';

List<SingleChildWidget> get providers {
  return [
    Provider(
      create: (context) => MainApi(),
    ),
    ChangeNotifierProvider<ScheduleRepositoryImpl>(
        create: (context) => ScheduleRepositoryImpl(api: MainApi())
    ),
  ];
}