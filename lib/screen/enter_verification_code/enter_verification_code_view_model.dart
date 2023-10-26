import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';
import 'package:vote_engine_frontend_example/services/contract_service.dart';
import 'package:vote_engine_frontend_example/utils.dart';

class EnterVerificationCodeViewModel extends BaseViewModel {
  final ContractService _contractService = Get.find();

  final String phoneNumber;
  final void Function(String phoneNumber) gotoShowingVoteId;
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
      'callVerifyUserIdentifierApi',
      [[phoneNumber, codeController.text]]
    );
    await callResult.wait();
    print('$phoneNumber\'s callResult.data : ${callResult.data}');

    // Receive an event when ANY transfer occurs
    _contractService.contract.on('ResponseVerifyUser', (requestId, response, err, event) async {
      print('     requestId : $requestId');
      print('     response : ${convertHexToString(response)}');
      print('     err : ${convertHexToString(err)}');

      if(convertHexToString(err).isEmpty) {
        loading(false);
        changeStateToFailure();
      } else {
        gotoShowingVoteId(phoneNumber);
      }
    });
  }
}