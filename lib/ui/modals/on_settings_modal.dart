import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tv_shedule/common/widgets/modal.dart';
import 'package:file_picker/file_picker.dart';
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
                          // model.onGetScheduleFromDisk();
                          _pickFiles();
                          Navigator.pop(context);
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

  void _pickFiles() async {
    bool hasUserAborted = true;

    try {
      var pickedFiles = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => log(status.toString()),
        allowedExtensions: ['json'],
        dialogTitle: "Выберите файл с расписанием",
        initialDirectory: Directory.current.path,
        lockParentWindow: true,
        withData: true,
      ))
          ?.files;
      hasUserAborted = pickedFiles == null;

      String path = pickedFiles?[0].path ?? "";
      model.selectedPath = path;
      model.onGetScheduleFromDisk();
      log("good job");
    } on PlatformException catch (e) {
      log('Unsupported operation' + e.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}