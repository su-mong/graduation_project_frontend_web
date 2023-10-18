import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RequestVoteViewModel extends GetxController {
  final VoidCallback changeState;
  RequestVoteViewModel({required this.changeState});

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 3)).then((_) {
      isLoading.value = false;
    });
  }
}