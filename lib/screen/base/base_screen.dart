import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:vote_engine_frontend_example/screen/base/base_view_model.dart';

abstract class BaseScreen<T extends BaseViewModel> extends GetView<T> {
  const BaseScreen({super.key});

  @protected
  double get cardWidth => 1408.h;

  @protected
  double get cardHeight => 878.h;

  @protected
  EdgeInsets get cardPadding => EdgeInsets.only(top: 16.h, bottom: 28.h, left: 18.h, right: 18.h);

  @protected
  Widget get buildCardChild;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/lol_park.jpeg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    const Color(0xFF05293C).withOpacity(0.8),
                    BlendMode.plus,
                  ),
                ),
              ),
              child: Center(
                child: Container(
                  width: cardWidth,
                  height: cardHeight,
                  color: const Color(0xB3000000),
                  padding: cardPadding,
                  child: buildCardChild,
                ),
              ),
            ),

            Obx(
              () => controller.loading.value
                  ? Container(
                color: const Color(0xB3000000),
                alignment: Alignment.center,
                child: const SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ) : const SizedBox.shrink()
            ),
          ],
        ),
      ),
    );
  }
}