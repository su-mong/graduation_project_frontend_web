import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EnterPhoneNumberViewModel extends GetxController {
  final VoidCallback changeState;

  EnterPhoneNumberViewModel({required this.changeState});

  final TextEditingController phoneController = TextEditingController();

  void submitPhoneNumber() {
    changeState();
  }
}