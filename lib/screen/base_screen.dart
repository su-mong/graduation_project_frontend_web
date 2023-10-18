import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

abstract class BaseScreen<T> extends GetView<T> {
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
        body: Container(
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
      ),
    );
  }
}