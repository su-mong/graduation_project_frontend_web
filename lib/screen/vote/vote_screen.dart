import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:vote_engine_frontend_example/enums/vote_button_state.dart';
import 'package:vote_engine_frontend_example/models/player_info.dart';
import 'package:vote_engine_frontend_example/screen/base/base_screen.dart';
import 'package:vote_engine_frontend_example/screen/vote/vote_view_model.dart';
import 'package:vote_engine_frontend_example/widget/main_button.dart';

class VoteScreen extends BaseScreen<VoteViewModel> {
  const VoteScreen({super.key});

  @override
  // TODO: implement buildCardChild
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

        Obx(
          () => Text(
            controller.voteStage.value.description,
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.w400,
              height: 26 / 30,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
        SizedBox(height: 26.h),

        Obx(
          () => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.playerList.length ~/ 5,
            itemBuilder: (_, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => _button(controller.playerList[index*5], state: controller.playerState[index*5].value, selectThis: () => controller.selectThis(index*5))),
                Obx(() => _button(controller.playerList[index*5+1], state: controller.playerState[index*5+1].value, selectThis: () => controller.selectThis(index*5+1))),
                Obx(() => _button(controller.playerList[index*5+2], state: controller.playerState[index*5+2].value, selectThis: () => controller.selectThis(index*5+2))),
                Obx(() => _button(controller.playerList[index*5+3], state: controller.playerState[index*5+3].value, selectThis: () => controller.selectThis(index*5+3))),
                Obx(() => _button(controller.playerList[index*5+4], state: controller.playerState[index*5+4].value, selectThis: () => controller.selectThis(index*5+4))),
              ],
            ),
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
          ),
        ),

        const Spacer(),
        MainButton(
          onTap: controller.goNextStage,
          text: 'Next',
        ),
      ],
    );
  }

  Widget _button(
    PlayerInfo playerInfo, {
    required VoteButtonState state,
    required VoidCallback selectThis,
  }) {
    return InkWell(
      onTap: selectThis,
      child: Container(
        width: 268.h,
        height: 226.h,
        decoration: BoxDecoration(
          color: state.isSelecting
              ? playerInfo.teamMainColor.withOpacity(playerInfo.teamSelectingBackgroundOpacity)
              : playerInfo.teamMainColor.withOpacity(0.2),
          border: state.isSelecting
              ? Border.all(color: playerInfo.teamMainColor, width: 6.h)
              : null,
          borderRadius: BorderRadius.circular(16.h),
        ),
        child: Stack(
          children: [
            if(state.isSelecting || state.isSelected)
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
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}