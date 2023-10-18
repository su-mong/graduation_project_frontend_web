import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterVerificationCodeViewModel extends GetxController {
  final VoidCallback changeStateToSuccess;
  final VoidCallback changeStateToFailure;

  EnterVerificationCodeViewModel({
    required this.changeStateToSuccess,
    required this.changeStateToFailure,
  });

  final TextEditingController codeController = TextEditingController();

  void submitVerificationCode() {
    changeStateToSuccess();
  }
}