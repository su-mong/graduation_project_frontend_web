import 'package:flutter/foundation.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';

class ShowingVoteIdViewModel extends BaseViewModel {
  final VoidCallback changeState;
  final String voteId;

  ShowingVoteIdViewModel({
    required this.changeState,
    required this.voteId,
  });

  void gotoVote() {
    changeState();
  }
}