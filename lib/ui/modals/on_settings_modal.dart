import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tv_shedule/common/widgets/modal.dart';
import 'package:tv_shedule/common/widgets/modal_builder.dart';
import 'package:tv_shedule/ui/schedule/provider/data_provider.dart';

class OnOpenSettingsModal implements Modal {
  final ScheduleViewModel model;

  OnOpenSettingsModal({required this.model});

  @override
  Widget buildContent(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text("Выберите откуда достать файл с расписанием"),
            ),
            SizedBox(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: GestureDetector(
                        onTap: (){
                          model.isNetwork = false;
                          model.onGetScheduleFromDisk();
                        },
                        child: Icon(Icons.sd_storage, size: 80,),
                      ),
                    )
                  ),
                  Expanded(
                    child: Card(
                      child: GestureDetector(
                        onTap: (){
                          model.isNetwork = true;
                          model.onGetScheduleByNetwork();
                        },
                        child: Icon(Icons.network_wifi, size: 80,),
                      ),
                    )
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }

  @override
  void buildModal(BuildContext context) {
    buildDefaultModal(context, buildContent(context));
  }
}