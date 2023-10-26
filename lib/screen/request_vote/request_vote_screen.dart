import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/screen/base/base_screen.dart';
import 'package:vote_engine_frontend_example/screen/request_vote/request_vote_view_model.dart';
import 'package:vote_engine_frontend_example/widget/main_button.dart';

class RequestVoteScreen extends BaseScreen<RequestVoteViewModel> {
  const RequestVoteScreen({super.key});

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

        Expanded(
          child: Center(
            child: Obx(
              () => Text(
                controller.loading.value
                    ? 'Your vote results are being transmitted.\n\nPlease wait a moment.'
                    : 'The result of the vote was reflected normally.\n\nThank you for your participation.',
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w400,
                  height: 26 / 40,
                  color: const Color(0xFFFFFFFF),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        Obx(
          () {
            if(controller.loading.value) {
              return const SizedBox();
            }

            return MainButton(
              onTap: controller.changeState,
              text: 'Check my vote result',
            );
          }
        )
      ],
    );
  }
}