import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';
import 'package:vote_engine_frontend_example/screen/page_state.dart';

class MainViewModel extends GetxController {
  List<dynamic> pageArguments = [];
  final Rx<PageState> _pageState = Rx(PageState.start);
  PageState get pageState => _pageState.value;

  void changeState(PageState state) => _pageState.value = state;

  void gotoEnterVerificationCode(String phoneNumber) {
    pageArguments = [phoneNumber];
    changeState(PageState.enterVerificationCode);
  }

  void gotoShowingVoteId(String voteId) {
    pageArguments = [voteId];
    changeState(PageState.showingVoteId);
  }

  void gotoConfirmVote({required PlayerInfo first, required PlayerInfo second, required PlayerInfo third}) {
    pageArguments = [first, second, third];
    changeState(PageState.confirmVote);
  }
}