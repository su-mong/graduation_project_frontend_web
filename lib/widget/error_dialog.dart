import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/widget/main_button.dart';

class ErrorDialog extends Dialog {
  final String message;
  final bool showTwoButton;
  final VoidCallback? onClickSubmit;
  final VoidCallback? onClickCancel;

  ErrorDialog({
    super.key,
    required this.message,
    this.showTwoButton = false,
    this.onClickSubmit,
    this.onClickCancel,
  }) : super(
    child: Container(
      width: 200.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 30.sp,
              height: 26 / 30,
              color: const Color(0xFF000000),
            ),
          ),
          Row(
            children: [
              if(showTwoButton)
                Expanded(
                  child: MainButton(
                    width: 100.w,
                    onTap: onClickCancel ?? Get.back,
                    text: 'Cancel',
                  ),
                ),


              Expanded(
                child: MainButton(
                  width: showTwoButton ? 100.w : 200.w,
                  onTap: onClickSubmit ?? Get.back,
                  text: 'Okay',
                ),
              ),
            ],
          ),
        ],
      ),
    )
  );
}