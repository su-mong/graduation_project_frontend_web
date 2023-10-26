import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';
import 'package:vote_engine_frontend_example/services/contract_service.dart';

class ShowingVoteIdViewModel extends BaseViewModel {
  final ContractService _contractService = Get.find();

  final VoidCallback changeState;
  final String phoneNumber;
  final RxString voteId = RxString('CLICK TO GET VOTEID');

  ShowingVoteIdViewModel({
    required this.changeState,
    required this.phoneNumber,
  });

  void getVoteId() async {
    loading(true);
    final voteIdResult = await _contractService.contract.send(
      'issueVoteId',
      [phoneNumber],
    );
    await voteIdResult.wait();
    print('voteIdResult.data : ${voteIdResult.data}');

    final callResult = await _contractService.contract.call<String>('showUserVoteId');
    _contractService.voteId = callResult;
    voteId.value = callResult;

    loading(false);
  }

  void gotoVote() {
    changeState();
  }
}