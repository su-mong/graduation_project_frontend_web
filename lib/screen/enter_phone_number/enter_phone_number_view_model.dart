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

    gotoEnterVerificationCode(phoneController.text.replaceAll('-', ''));
  }
}