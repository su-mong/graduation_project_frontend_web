import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/networks/auth_connect.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';
import 'package:vote_engine_frontend_example/widget/error_dialog.dart';

class EnterPhoneNumberViewModel extends BaseViewModel {
  final void Function(String phoneNumber) gotoEnterVerificationCode;

  EnterPhoneNumberViewModel({required this.gotoEnterVerificationCode});

  final TextEditingController phoneController = TextEditingController();

  Future<void> submitPhoneNumber() async {
    loading(true);
    final result = await AuthConnect().sendRequestCode(
      phoneNumber: phoneController.text.replaceAll('-', ''),
    );
    loading(false);

    if(result) {
      gotoEnterVerificationCode(phoneController.text.replaceAll('-', ''));
    } else {
      Get.dialog(
        ErrorDialog(message: '오류가 발생했습니다. 다시 시도해 주세요.'),
      );
    }
  }
}