import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';
import 'package:vote_engine_frontend_example/services/contract_service.dart';
import 'package:vote_engine_frontend_example/utils.dart';

class EnterPhoneNumberViewModel extends BaseViewModel {
  final ContractService _contractService = Get.find();
  final void Function(String phoneNumber) gotoEnterVerificationCode;

  EnterPhoneNumberViewModel({required this.gotoEnterVerificationCode});

  final TextEditingController phoneController = TextEditingController();

  Future<void> submitPhoneNumber() async {
    loading(true);

    final callResult = await _contractService.contract.send(
      'sendVerificationCode',
      [[phoneController.text.replaceAll('-', '')]],
    );
    await callResult.wait();
    print('${phoneController.text.replaceAll('-', '')}\'s callResult.data : ${callResult.data}');

    // Receive an event when ANY transfer occurs
    _contractService.contract.on('ResponseSendCode', (requestId, response, err, event) {
      print('     requestId : $requestId');
      print('     response : ${convertHexToString(response)}');
      print('     err : ${convertHexToString(err)}');
      // Event.fromJS(event); // Event: Transfer Transfer(address,address,uint256) with args [0x0648ff5de80Adf54aAc07EcE2490f50a418Dde23, 0x12c64E61440582793EF4964A36d98020d83490a3, 1015026418461703883891]
      loading(false);
      gotoEnterVerificationCode(phoneController.text.replaceAll('-', ''));
    });
  }
}