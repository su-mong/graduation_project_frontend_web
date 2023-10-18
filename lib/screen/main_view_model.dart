import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';
import 'package:vote_engine_frontend_example/screen/page_state.dart';

class MainViewModel extends GetxController {
  List<dynamic> pageArguments = [];
  final Rx<PageState> _pageState = Rx(PageState.voteResult);
  PageState get pageState => _pageState.value;

  void changeState(PageState state) => _pageState.value = state;

  void gotoConfirmVote({required PlayerInfo first, required PlayerInfo second, required PlayerInfo third}) {
    pageArguments = [first, second, third];
    changeState(PageState.confirmVote);
  }
}