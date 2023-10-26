import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';
import 'package:vote_engine_frontend_example/services/contract_service.dart';
import 'package:vote_engine_frontend_example/widget/error_dialog.dart';

class RequestVoteViewModel extends BaseViewModel {
  final ContractService _contractService = Get.find();

  final PlayerInfo first;
  final PlayerInfo second;
  final PlayerInfo third;
  final VoidCallback changeState;
  RequestVoteViewModel({
    required this.first,
    required this.second,
    required this.third,
    required this.changeState
  });

  @override
  Future<void> onReady() async {
    super.onInit();

    if(_contractService.voteId != null) {
      loading(true);

      final voteIdResult = await _contractService.contract.send(
        'selectFirst',
        [_contractService.voteId, first.name, second.name, third.name],
      );
      await voteIdResult.wait();

      loading(false);
    } else {
      Get.dialog(
        ErrorDialog(message: 'voteId를 찾을 수 없습니다. 다시 시도해 주세요.'),
      );
    }
  }
}