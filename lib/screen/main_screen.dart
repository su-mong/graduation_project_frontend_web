import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vote_engine_frontend_example/screen/confirm_vote/confirm_vote_screen.dart';
import 'package:vote_engine_frontend_example/screen/confirm_vote/confirm_vote_view_model.dart';
import 'package:vote_engine_frontend_example/screen/enter_phone_number/enter_phone_number_screen.dart';
import 'package:vote_engine_frontend_example/screen/enter_phone_number/enter_phone_number_view_model.dart';
import 'package:vote_engine_frontend_example/screen/enter_verification_code/enter_verification_code_screen.dart';
import 'package:vote_engine_frontend_example/screen/enter_verification_code/enter_verification_code_view_model.dart';
import 'package:vote_engine_frontend_example/screen/my_vote/my_vote_screen.dart';
import 'package:vote_engine_frontend_example/screen/my_vote/my_vote_view_model.dart';
import 'package:vote_engine_frontend_example/screen/request_vote/request_vote_screen.dart';
import 'package:vote_engine_frontend_example/screen/request_vote/request_vote_view_model.dart';
import 'package:vote_engine_frontend_example/screen/showing_vote_id/showing_vote_id_screen.dart';
import 'package:vote_engine_frontend_example/screen/showing_vote_id/showing_vote_id_view_model.dart';
import 'package:vote_engine_frontend_example/screen/start/start_screen.dart';
import 'package:vote_engine_frontend_example/screen/start/start_view_model.dart';
import 'package:vote_engine_frontend_example/screen/main_view_model.dart';
import 'package:vote_engine_frontend_example/screen/page_state.dart';
import 'package:vote_engine_frontend_example/screen/vote/vote_screen.dart';
import 'package:vote_engine_frontend_example/screen/vote/vote_view_model.dart';
import 'package:vote_engine_frontend_example/screen/vote_result/vote_result_screen.dart';
import 'package:vote_engine_frontend_example/screen/vote_result/vote_result_view_model.dart';

class MainScreen extends GetView<MainViewModel> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        switch(controller.pageState) {
          /// 시작
          case PageState.start:
            Get.put<StartViewModel>(
              StartViewModel(
                changeState: () => controller.changeState(PageState.enterPhoneNumber),
              ),
            );
            return const StartScreen();

          /// 전화번호 입력
          case PageState.enterPhoneNumber:
            Get.put<EnterPhoneNumberViewModel>(
              EnterPhoneNumberViewModel(
                gotoEnterVerificationCode: controller.gotoEnterVerificationCode,
              ),
            );
            return const EnterPhoneNumberScreen();

          /// 인증번호 입력
          case PageState.enterVerificationCode:
            Get.put<EnterVerificationCodeViewModel>(
              EnterVerificationCodeViewModel(
                phoneNumber: controller.pageArguments[0],
                gotoShowingVoteId: controller.gotoShowingVoteId,
                changeStateToFailure: () => controller.changeState(PageState.failIdentification),
              ),
            );
            return const EnterVerificationCodeScreen();

          /// voteId 표시
          case PageState.showingVoteId:
            Get.put<ShowingVoteIdViewModel>(
              ShowingVoteIdViewModel(
                phoneNumber: controller.pageArguments[0],
                changeState: () => controller.changeState(PageState.vote),
              ),
            );
            return const ShowingVoteIdScreen();

          /// 인증 실패
          case PageState.failIdentification:
            return Container();

          /// 1등 선수에게 투표
          case PageState.vote:
            Get.put<VoteViewModel>(
              VoteViewModel(
                gotoConfirmVote: controller.gotoConfirmVote,
              ),
            );
            return const VoteScreen();

          /// 내 선택지 확인
          case PageState.confirmVote:
            Get.put<ConfirmVoteViewModel>(
              ConfirmVoteViewModel(
                first: controller.pageArguments[0],
                second: controller.pageArguments[1],
                third: controller.pageArguments[2],
                changeState: () => controller.changeState(PageState.requestVote),
              ),
            );
            return const ConfirmVoteScreen();

          /// 유저 선택지 전송 및 결과 확인
          case PageState.requestVote:
            Get.put<RequestVoteViewModel>(
              RequestVoteViewModel(
                first: controller.pageArguments[0],
                second: controller.pageArguments[1],
                third: controller.pageArguments[2],
                changeState: () => controller.changeState(PageState.voteResult),
              ),
            );
            return const RequestVoteScreen();

          /// 내 선택지를 보여줌 (이미 투표한 유저인 경우)
          case PageState.myVote:
            Get.put<MyVoteViewModel>(
              MyVoteViewModel(),
            );
            return const MyVoteScreen();

          /// 투표 전체 결과를 보여줌 (투표 마감인 경우)
          case PageState.voteResult:
            Get.put<VoteResultViewModel>(VoteResultViewModel());
            return const VoteResultScreen();
        }
      }
    );
  }
}