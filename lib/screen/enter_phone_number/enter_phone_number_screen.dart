import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vote_engine_frontend_example/screen/base_screen.dart';
import 'package:vote_engine_frontend_example/screen/enter_phone_number/enter_phone_number_view_model.dart';
import 'package:vote_engine_frontend_example/widget/main_button.dart';
import 'package:vote_engine_frontend_example/widget/main_input_field.dart';

class EnterPhoneNumberScreen extends BaseScreen<EnterPhoneNumberViewModel> {
  const EnterPhoneNumberScreen({super.key});

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
            'Enter your phone number : ',
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
          textController: controller.phoneController,
          hintText: 'Enter your phone number',
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
            // This formatter will add dashes after the second and sixth digit.
            _PhoneTextInputFormatter(),
          ],
        ),
        /*SizedBox(height: 16.h),

        SizedBox(
          width: 754.h,
          child: Text(
            '· The Vote ID is used to check the options you voted for, or to proceed with a vote that you couldn\'t finish.'
                '\n· If you lose your Vote ID, there\'s no way to find it, so make sure to write it down somewhere else.',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              height: 26 / 22,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),*/
        const Spacer(),

        MainButton(
          onTap: controller.submitPhoneNumber,
          text: 'Submit',
        ),
      ],
    );
  }
}

class _PhoneTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the new value is empty or the same as the old value, return as is.
    if (newValue.text.isEmpty || newValue.text == oldValue.text) {
      return newValue;
    }

    // Remove any dashes from the new value.
    String strippedValue = newValue.text.replaceAll(RegExp('-'), '');

    // Add dashes after the second and sixth digit.
    String formattedValue = '';

    late final int secondSeparatorIndex;
    if(strippedValue.length > 10) {
      secondSeparatorIndex = 7;
    } else {
      secondSeparatorIndex = 6;
    }

    for (int i = 0; i < strippedValue.length; i++) {
      if (i == 3 || i == secondSeparatorIndex) {
        formattedValue += '-';
      }
      formattedValue += strippedValue[i];
    }

    // Return the formatted value.
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
