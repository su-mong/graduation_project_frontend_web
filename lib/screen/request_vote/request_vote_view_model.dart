import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';

class RequestVoteViewModel extends BaseViewModel {
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