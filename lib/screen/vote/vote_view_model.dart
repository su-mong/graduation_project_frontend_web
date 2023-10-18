import 'dart:ui';

import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/enums/vote_button_state.dart';
import 'package:vote_engine_frontend_example/enums/vote_stage.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';

class VoteViewModel extends GetxController {
  final void Function({required PlayerInfo first, required PlayerInfo second, required PlayerInfo third}) gotoConfirmVote;
  VoteViewModel({required this.gotoConfirmVote});

  final Rx<VoteStage> voteStage = VoteStage.first.obs;
  final RxList<PlayerInfo> playerList = RxList();
  final List<Rx<VoteButtonState>> playerState = [];

  PlayerInfo? _first;
  PlayerInfo? _second;
  PlayerInfo? _third;

  @override
  void onInit() {
    super.onInit();

    playerList.value = const [
      PlayerInfo(
        teamMainColor: Color(0xFFAB8A00),
        teamSelectingBackgroundOpacity: 0.6,
        profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/chovy.png',
        name: 'Chovy',
        teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/geng.png',
        teamName: 'GEN',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFE4002C),
        teamSelectingBackgroundOpacity: 0.5,
        profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/faker.png',
        name: 'Faker',
        teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/t1.png',
        teamName: 'T1',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFFF0806),
        teamSelectingBackgroundOpacity: 0.5,
        profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/bdd.png',
        name: 'Bdd',
        teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/kt.png',
        teamName: 'KT',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFFF6C02),
        teamSelectingBackgroundOpacity: 0.6,
        profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/zeka.png',
        name: 'Zeka',
        teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/hanwha.png',
        teamName: 'HLE',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFE3EE84),
        teamSelectingBackgroundOpacity: 0.5,
        profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/showmaker.png',
        name: 'ShowMaker',
        teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/dplus.png',
        teamName: 'DK',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFFFC900),
        teamSelectingBackgroundOpacity: 0.5,
        profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/clozer.png',
        name: 'Clozer',
        teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/liiv.png',
        teamName: 'LSB',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFE73312),
        teamSelectingBackgroundOpacity: 0.6,
        profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/bulldog.png',
        name: 'BuLLDoG',
        teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/freecs.png',
        teamName: 'KDF',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFF01492B),
        teamSelectingBackgroundOpacity: 0.6,
        profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/karis.png',
        name: 'Karis',
        teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/brion.png',
        teamName: 'BRO',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFF1002A3),
        teamSelectingBackgroundOpacity: 0.6,
        profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/fate.png',
        name: 'FATE',
        teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/drx.png',
        teamName: 'DRX',
      ),
      PlayerInfo(
        teamMainColor: Color(0xFFDF2027),
        teamSelectingBackgroundOpacity: 0.6,
        profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/fiesta.png',
        name: 'FIESTA',
        teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/nongshim.png',
        teamName: 'NS',
      ),
    ];

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
}