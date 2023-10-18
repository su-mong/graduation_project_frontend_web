import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';

class VoteResultViewModel extends GetxController {
  final PlayerInfo first = const PlayerInfo(
    teamMainColor: Color(0xFFAB8A00),
    teamSelectingBackgroundOpacity: 0.6,
    profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/chovy.png',
    name: 'Chovy',
    teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/geng.png',
    teamName: 'GEN',
  );

  final PlayerInfo second = const PlayerInfo(
    teamMainColor: Color(0xFFE4002C),
    teamSelectingBackgroundOpacity: 0.5,
    profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/faker.png',
    name: 'Faker',
    teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/t1.png',
    teamName: 'T1',
  );

  final PlayerInfo third = const PlayerInfo(
    teamMainColor: Color(0xFFFF0806),
    teamSelectingBackgroundOpacity: 0.5,
    profileUrl: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/bdd.png',
    name: 'Bdd',
    teamLogoSrc: 'https://raw.githubusercontent.com/su-mong/graduation_project/main/images/kt.png',
    teamName: 'KT',
  );
}