import 'dart:ui';

class PlayerInfo {
  final Color teamMainColor;
  final double teamSelectingBackgroundOpacity;
  final String profileUrl;
  final String name;
  final String teamLogoSrc;
  final String teamName;

  const PlayerInfo({
    required this.teamMainColor,
    required this.teamSelectingBackgroundOpacity,
    required this.profileUrl,
    required this.name,
    required this.teamLogoSrc,
    required this.teamName,
  });
}