import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_shedule/ui/schedule/provider/data_provider.dart';
import 'package:tv_shedule/ui/schedule/screen/schedule_page.dart';

class NavigationRouter {
  late final GoRouter _router;

  GoRouter get router => _router;

  NavigationRouter(){
    _router = GoRouter(
        initialLocation: "/",
        debugLogDiagnostics: true,
        routes: _pageList
    );
  }

  List<RouteBase> get _pageList => [
    GoRoute(
        path: "/",
        builder: (context, state){
          return SchedulePage(
            scheduleViewModel: ScheduleViewModel(
                repository: context.read(),
            ),
          );
        }
    )
  ];
}