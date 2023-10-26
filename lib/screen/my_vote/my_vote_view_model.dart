import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';
import 'package:vote_engine_frontend_example/services/contract_service.dart';
import 'package:vote_engine_frontend_example/widget/error_dialog.dart';

class MyVoteViewModel extends BaseViewModel {
  List<PlayerInfo> _playerList = [];
  final ContractService _contractService = Get.find();

  final Rxn<PlayerInfo> first = Rxn();
  final Rxn<PlayerInfo> second = Rxn();
  final Rxn<PlayerInfo> third = Rxn();

  @override
  Future<void> onInit() async {
    super.onInit();

    if(_contractService.voteId == null) {
      Get.dialog(
        ErrorDialog(message: 'voteId를 찾을 수 없습니다. 다시 시도해 주세요.'),
      );
      return;
    }

    loading(true);

    final callResult = json.decode(await _contractService.contract.call<String>('callOptionsMetadata'));
    print('callResult.data : $callResult (${callResult.runtimeType})');

    _playerList = ((callResult as Map<String, dynamic>)['data'] as List<dynamic>).map(
          (player) {
        final playerMap = player as Map<String, dynamic>;

        return PlayerInfo(
          teamMainColor: Color(int.parse(playerMap['mainColor'], radix: 16)),
          teamSelectingBackgroundOpacity: playerMap['teamSelectingBackgroundOpacityPercent'],
          profileUrl: playerMap['smallProfileUrl'],
          name: playerMap['name'],
          teamLogoSrc: playerMap['teamLogoUrl'],
          teamName: playerMap['teamName'],
        );
      },
    ).toList();

    final userVoteResult = json.decode(await _contractService.contract.call<String>(
        'getUserVoteRecord',
        [_contractService.voteId]
    ));
    print('callResult.data : $userVoteResult (${userVoteResult.runtimeType})');

    first.value = _playerList.firstWhere((element) => element.name == ((userVoteResult as Map<String, dynamic>)['first']).toString());
    second.value = _playerList.firstWhere((element) => element.name == ((userVoteResult as Map<String, dynamic>)['second']).toString());
    third.value = _playerList.firstWhere((element) => element.name == ((userVoteResult as Map<String, dynamic>)['third']).toString());

    loading(false);
  }
}