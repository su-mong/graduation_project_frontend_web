import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final bool isGreen;

  const MainButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.isGreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 520.h,
        height: 80.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isGreen
              ? const Color(0xFF11DBC5).withOpacity(0.4)
              : const Color(0xFFFFFFFF).withOpacity(0.1),
          border: Border.all(color: const Color(0xFFFFFFFF), width: 1.h),
          borderRadius: BorderRadius.circular(8.h),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}