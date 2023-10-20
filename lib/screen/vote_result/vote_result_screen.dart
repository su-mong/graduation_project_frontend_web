import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vote_engine_frontend_example/enums/vote_button_state.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';
import 'package:vote_engine_frontend_example/screen/base/base_screen.dart';
import 'package:vote_engine_frontend_example/screen/vote_result/vote_result_view_model.dart';

class VoteResultScreen extends BaseScreen<VoteResultViewModel> {
  const VoteResultScreen({super.key});

  @override
  Widget get buildCardChild {
    return Column(
      children: [
        Image.asset(
          'assets/logo.png',
          fit: BoxFit.cover,
          width: 267.h,
          height: 141.h,
        ),
        SizedBox(height: 26.h),

        Text(
          'Vote Result',
          style: TextStyle(
            fontSize: 35.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 26.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _contents(controller.first, state: VoteButtonState.isFirst),
            SizedBox(width: 106.h),
            _contents(controller.second, state: VoteButtonState.isSecond),
            SizedBox(width: 106.h),
            _contents(controller.third, state: VoteButtonState.isThird),
          ],
        ),
      ],
    );
  }

  Widget _contents(
    PlayerInfo playerInfo, {
    required VoteButtonState state,
  }) {
    return Container(
      width: 268.h,
      height: 500.h,
      decoration: BoxDecoration(
        color: playerInfo.teamMainColor.withOpacity(playerInfo.teamSelectingBackgroundOpacity),
        border: Border.all(color: playerInfo.teamMainColor, width: 6.h),
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: Stack(
        children: [
          Image.asset(
            state.medalSrc!,
            width: 64.h,
            height: 64.h,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  playerInfo.profileUrl,
                  width: 159.h,
                  height: 126.h,
                ),
                SizedBox(height: 16.h),
                Text(
                  playerInfo.name,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    height: 26 / 30,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      playerInfo.teamLogoSrc,
                      height: 22.h,
                    ),
                    SizedBox(width: 6.h),
                    Text(
                      playerInfo.teamName,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        height: 26 / 24,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}