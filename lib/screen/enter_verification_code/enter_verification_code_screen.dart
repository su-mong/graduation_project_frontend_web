import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vote_engine_frontend_example/screen/base/base_screen.dart';
import 'package:vote_engine_frontend_example/screen/enter_verification_code/enter_verification_code_view_model.dart';
import 'package:vote_engine_frontend_example/widget/main_button.dart';
import 'package:vote_engine_frontend_example/widget/main_input_field.dart';

class EnterVerificationCodeScreen extends BaseScreen<EnterVerificationCodeViewModel> {
  const EnterVerificationCodeScreen({super.key});

  @override
  double get cardWidth => 1000.h;

  @override
  double get cardHeight => 600.h;

  @override
  EdgeInsets get cardPadding => EdgeInsets.only(top: 12.h, bottom: 65.h);

  @override
  Widget get buildCardChild {
    return Column(
      children: [
        Image.asset(
          'assets/logo.png',
          fit: BoxFit.cover,
          width: 267.h,
          height: 141.h,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 754.h,
          child: Text(
            'Please enter the authentication code received through SMS : ',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 30.sp,
              height: 26 / 30,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
        SizedBox(height: 12.h),

        MainInputField(
          textController: controller.codeController,
          hintText: 'Enter your code',
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
          ],
        ),
        SizedBox(height: 16.h),

        SizedBox(
          width: 754.h,
          child: Text(
            '· It may take up to 5 minutes to receive SMS.'
                '\n· If SMS doesn\'t come, please check if overseas text is blocked.',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              height: 26 / 22,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
        const Spacer(),

        MainButton(
          onTap: controller.submitVerificationCode,
          text: 'Submit',
        ),
      ],
    );
  }
}