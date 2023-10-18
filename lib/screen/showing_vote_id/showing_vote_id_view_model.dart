import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ShowingVoteIdViewModel extends GetxController {
  final VoidCallback changeState;

  ShowingVoteIdViewModel({required this.changeState});

  final RxString voteId = ''.obs;

  @override
  void onInit() {
    super.onInit();

    voteId.value = '249c5386-3c52-11ee-be56-0242ac120002';
  }

  void gotoVote() {
    changeState();
  }
}