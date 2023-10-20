import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vote_engine_frontend_example/screen/base/base_screen.dart';
import 'package:vote_engine_frontend_example/screen/start/start_view_model.dart';
import 'package:vote_engine_frontend_example/widget/main_button.dart';

class StartScreen extends BaseScreen<StartViewModel> {
  const StartScreen({super.key});

  @override
  double get cardWidth => 1000.h;

  @override
  double get cardHeight => 600.h;

  @override
  EdgeInsets get cardPadding => EdgeInsets.only(top: 25.h, bottom: 65.h);

  @override
  Widget get buildCardChild {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/logo.png',
          fit: BoxFit.cover,
          width: 350.h,
          height: 185.h,
        ),
        SizedBox(height: 36.h),
        Text(
          'Hello! Welcome to the AllStar Vote website.\n\nIdentification is required for the All-Star vote.',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 30.sp,
            height: 26 / 30,
            color: const Color(0xFFFFFFFF),
          ),
          textAlign: TextAlign.center,
        ),

        const Spacer(),
        MainButton(
          onTap: controller.gotoNext,
          text: 'Let’s start!',
        ),
      ],
    );
  }
}