import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vote_engine_frontend_example/screen/base/base_screen.dart';
import 'package:vote_engine_frontend_example/screen/showing_vote_id/showing_vote_id_view_model.dart';
import 'package:vote_engine_frontend_example/widget/main_button.dart';

class ShowingVoteIdScreen extends BaseScreen<ShowingVoteIdViewModel> {
  const ShowingVoteIdScreen({super.key});

  @override
  double get cardWidth => 1000.h;

  @override
  double get cardHeight => 600.h;

  @override
  EdgeInsets get cardPadding => EdgeInsets.only(top: 12.h, bottom: 65.h);

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
        SizedBox(height: 16.h),
        SizedBox(
          width: 754.h,
          child: Text(
            'Remember your Vote ID : ',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 30.sp,
              height: 26 / 30,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
        SizedBox(height: 4.h),

        Container(
          width: 754.h,
          height: 100.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: Text(
            controller.voteId,
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              height: 26 / 36,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
        SizedBox(height: 16.h),

        SizedBox(
          width: 754.h,
          child: Text(
            '· The Vote ID is used to check the options you voted for, or to proceed with a vote that you couldn\'t finish.'
                '\n· If you lose your Vote ID, there\'s no way to find it, so make sure to write it down somewhere else.',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              height: 26 / 22,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
        const Spacer(),

        MainButton(
          onTap: controller.gotoVote,
          text: 'Go to Vote',
        ),
      ],
    );
  }
}