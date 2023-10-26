import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/enums/vote_button_state.dart';
import 'package:vote_engine_frontend_example/enums/vote_stage.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';
import 'package:vote_engine_frontend_example/services/contract_service.dart';

class VoteViewModel extends BaseViewModel {
  final ContractService _contractService = Get.find();

  final void Function({required PlayerInfo first, required PlayerInfo second, required PlayerInfo third}) gotoConfirmVote;
  VoteViewModel({required this.gotoConfirmVote});

  final Rx<VoteStage> voteStage = VoteStage.first.obs;
  final RxList<PlayerInfo> playerList = RxList();
  final List<Rx<VoteButtonState>> playerState = [];

  PlayerInfo? _first;
  PlayerInfo? _second;
  PlayerInfo? _third;

  @override
  Future<void> onInit() async {
    super.onInit();

    loading(true);

    final callResult = json.decode(await _contractService.contract.call<String>('callOptionsMetadata'));
    print('callResult.data : $callResult (${callResult.runtimeType})');

    playerList.value = ((callResult as Map<String, dynamic>)['data'] as List<dynamic>).map(
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

    loading(false);

    for(var i=0; i<playerList.length; i++) {
      playerState.add(VoteButtonState.unSelected.obs);
    }
  }

  void goNextStage() {
    if(voteStage.value == VoteStage.third && _first != null && _second != null && _third != null) {
      gotoConfirmVote(
        first: _first!,
        second: _second!,
        third: _third!,
      );
    } else {
      for(var i = 0; i < playerState.length; i++) {
        if(playerState[i].value.isSelecting) {
          playerState[i].value = playerState[i].value.confirmSelect;
        }
      }

      voteStage.value = voteStage.value.next;
    }
  }

  void selectThis(int index) {
    if(playerState[index].value.isUnSelected) {
      switch(voteStage.value) {
        case VoteStage.first:
          playerState[index].value = VoteButtonState.selectFirst;
          _first = playerList[index];
          break;
        case VoteStage.second:
          playerState[index].value = VoteButtonState.selectSecond;
          _second = playerList[index];
          break;
        case VoteStage.third:
          playerState[index].value = VoteButtonState.selectThird;
          _third = playerList[index];
          break;
      }

      for(var i = 0; i < playerState.length; i++) {
        if(i != index && playerState[i].value.isSelected == false) {
          playerState[i].value = VoteButtonState.unSelected;
        }
      }
    }
  }

  /*
  PlayerInfo(
        teamMainColor: Color(0xFFAB8A00),
        teamSelectingBackgroundOpacity: 0.6,
        teamName: 'GEN',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFE4002C),
        teamSelectingBackgroundOpacity: 0.5,
        teamName: 'T1',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFFF0806),
        teamSelectingBackgroundOpacity: 0.5,
        teamName: 'KT',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFFF6C02),
        teamSelectingBackgroundOpacity: 0.6,
        teamName: 'HLE',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFE3EE84),
        teamSelectingBackgroundOpacity: 0.5,
        teamName: 'DK',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFFFC900),
        teamSelectingBackgroundOpacity: 0.5,
        teamName: 'LSB',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFE73312),
        teamSelectingBackgroundOpacity: 0.6,
        teamName: 'KDF',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFF01492B),
        teamSelectingBackgroundOpacity: 0.6,
        teamName: 'BRO',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFF1002A3),
        teamSelectingBackgroundOpacity: 0.6,
        teamName: 'DRX',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFDF2027),
        teamSelectingBackgroundOpacity: 0.6,
        teamName: 'NS',
      )
  */
}