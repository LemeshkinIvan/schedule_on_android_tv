import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tv_shedule/ui/modals/on_exit_modal.dart';
import 'package:tv_shedule/ui/modals/on_settings_modal.dart';
import 'package:tv_shedule/ui/schedule/provider/data_provider.dart';
import 'package:tv_shedule/ui/schedule/widgets/custom_search_bar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, required this.scheduleViewModel});

  final ScheduleViewModel scheduleViewModel;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late ScheduleViewModel model;
  String selectedDay = "";
  bool sortIsEnabled = false;

  @override
  void initState(){
    model = widget.scheduleViewModel;
    model.onGetScheduleFromDisk();
    selectedDay = model.selectedDay;
    super.initState();
  }

  late OnExitModal exitModal;
  late OnOpenSettingsModal settingsModal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text("Расписание", style: TextStyle(color: Colors.black),),),
        leading: buildExitButton(),
        actions: [buildSettingsButton()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 2.w
              ),
              child: ListenableBuilder(
                listenable: model,
                builder: (context, _){
                  return Text(
                    "Расписание на ${model.selectedDay.toLowerCase()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),
                  );
                }
              ),
            )
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h
              ),
              child: CustomSearchBar(model: model,),
            )
          ),
          Expanded(
            flex: 16,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w,),
              child: buildCard(),
            )
          ),
          Expanded(
            flex: 2,
            child: buildDaysRow()
          ),
        ],
      )
    );
  }

  Widget buildDaysRow(){
    return Center(
      child: SingleChildScrollView(
        child: Row(
          children: List.generate(model.days.length, (int index){
            return Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    model.selectedDay = model.days[index];
                    model.filterByDay(model.selectedDay, index);
                    log(model.selectedDay);
                  },
                  child: Text(model.days[index]),
                ),
              )
            );
          }),
        ),
      ),
    );
  }

  Widget buildTable(){
    var dataForTable = model.dataForTable;
    int length = dataForTable.length;

    return Column(
      children: List.generate(length, (index){
        var k = model.genMapOperation(model.filteredLessons, index);
        return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: k.entries.map((entry) => Expanded(
                  flex: entry.key.flexFactor,
                  child: Center(child: Text(entry.value))),)
                  .toList()
            )
        );
      }),
    );
  }

  Widget buildCard(){
    return Card(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: buildHeadersRow()
            )
          ),
          Expanded(
            flex: 12,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: RefreshIndicator(
                notificationPredicate: defaultScrollNotificationPredicate,
                onRefresh: () async {
                  if (model.isNetwork){
                    model.onGetScheduleByNetwork();
                  } else {
                    model.onGetScheduleFromDisk();
                  }
                },
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: SingleChildScrollView(
                    child: ListenableBuilder(
                      listenable: model,
                      builder: (context, child){
                        return model.isLoading
                          ? buildLoader()
                          : buildTable();
                      }
                    )
                  )
                )
              )
            )
          )
        ],
      ),
    );
  }

  Widget buildLoader(){
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 70.h),
        child: CircularProgressIndicator(color: Colors.blue,)
    );
  }
  
  Widget buildHeadersRow(){
    return Container(
      color: Colors.yellow,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(model.headers.length, (index){
          return Expanded(
            flex: 1,
            child: Center(
              child: model.headers[index] == "Пара" 
                  ? buildIconNumSubject(model.headers[index])
                  : Text(
                    model.headers[index], 
                    softWrap: true, 
                    maxLines: 1,
                    style: TextStyle(
                      height: 2.h,
                    ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildIconNumSubject(String name){
    return GestureDetector(
      onTap: (){
        setState(() {
          sortIsEnabled = !sortIsEnabled;
        });
        model.sortByNumberGroup(sortIsEnabled);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            softWrap: true,
            maxLines: 1,
            style: TextStyle(
              height: 2.h,
            )
          ),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  Widget buildExitButton(){
    return IconButton(
      onPressed: (){
        exitModal = OnExitModal();
        exitModal.buildModal(context);
      },
      icon: Icon(Icons.exit_to_app_rounded, color: Colors.black,)
    );
  }

  Widget buildSettingsButton(){
    return IconButton(
      onPressed: (){
        settingsModal = OnOpenSettingsModal(model: model);
        settingsModal.buildModal(context);
      },
      icon: Icon(Icons.settings, color: Colors.black,)
    );
  }
}
