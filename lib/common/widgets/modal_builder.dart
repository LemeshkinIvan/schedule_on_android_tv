import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void buildDefaultModal(BuildContext context, Widget child,
    {double? paddingForInnerWidgets,
      double? circularRadios,
      bool? dismissibleFlag}) {
  showGeneralDialog(
      barrierDismissible: dismissibleFlag ?? true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, a1, a2) {
        return Container();
      },
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
                opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
                child: AlertDialog(
                  insetPadding:
                  EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
                  contentPadding: EdgeInsets.zero,
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
                  content: IntrinsicHeight(
                      child: Padding(
                          padding:
                          EdgeInsets.all(paddingForInnerWidgets ?? 10.h),
                          child: child)),
                  shape: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(circularRadios ?? 32.r),
                      borderSide: BorderSide.none),
                )));
      });
}
