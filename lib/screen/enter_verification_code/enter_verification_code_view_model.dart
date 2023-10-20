import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';
import 'package:vote_engine_frontend_example/services/contract_service.dart';
import 'package:vote_engine_frontend_example/utils.dart';

class EnterVerificationCodeViewModel extends BaseViewModel {
  final ContractService _contractService = Get.find();

  final String phoneNumber;
  final void Function(String voteId) gotoShowingVoteId;
  final VoidCallback changeStateToFailure;

  EnterVerificationCodeViewModel({
    required this.phoneNumber,
    required this.gotoShowingVoteId,
    required this.changeStateToFailure,
  });

  final TextEditingController codeController = TextEditingController();

  Future<void> submitVerificationCode() async {
    loading(true);

    final callResult = await _contractService.contract.send(
      'verifyUserIdentifier',
      [phoneNumber, codeController.text],
    );
    await callResult.wait();
    print('$phoneNumber\'s callResult.data : ${callResult.data}');

    // Receive an event when ANY transfer occurs
    _contractService.contract.on('ResponseVerifyUser', (requestId, response, err, event) async {
      print('     requestId : $requestId');
      print('     response : ${convertHexToString(response)}');
      print('     err : ${convertHexToString(err)}');
      // Event.fromJS(event); // Event: Transfer Transfer(address,address,uint256) with args [0x0648ff5de80Adf54aAc07EcE2490f50a418Dde23, 0x12c64E61440582793EF4964A36d98020d83490a3, 1015026418461703883891]

      if(convertHexToString(err).isEmpty) {
        loading(false);
        changeStateToFailure();
      } else {
        final voteIdResult = await _contractService.contract.send(
          'issueVoteId',
          [_contractService.currentAddress, phoneNumber],
        );
        await voteIdResult.wait();
        print('voteIdResult.data : ${voteIdResult.data}');

        gotoShowingVoteId(voteIdResult.data);
      }
    });
  }
}