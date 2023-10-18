import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';

class ConfirmVoteViewModel extends GetxController {
  final PlayerInfo first;
  final PlayerInfo second;
  final PlayerInfo third;
  final VoidCallback changeState;

  ConfirmVoteViewModel({
    required this.first,
    required this.second,
    required this.third,
    required this.changeState,
  });

  void gotoRequestVote() {
    changeState();
  }
}