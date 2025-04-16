import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tv_shedule/common/widgets/modal.dart';
import 'package:tv_shedule/common/widgets/modal_builder.dart';

class OnExitModal implements Modal {
  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Text("Вы точно хотите выйти из приложения?"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 10.h
          ),
          child: SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => exit(0),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.grey)
                    ),
                    child: Text("Да"),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: SizedBox(),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Нет")
                  )
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void buildModal(BuildContext context) {
    buildDefaultModal(context, buildContent(context));
  }
}