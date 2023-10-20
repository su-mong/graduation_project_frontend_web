import 'package:flutter/foundation.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';

class ConfirmVoteViewModel extends BaseViewModel {
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