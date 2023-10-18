import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainInputField extends StatelessWidget {
  final TextEditingController textController;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;

  const MainInputField({
    super.key,
    required this.textController,
    this.hintText,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 754.h,
      height: 100.h,
      child: TextFormField(
        controller: textController,
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFFFFFFF),
        ),
        inputFormatters: inputFormatters,
        cursorColor: const Color(0xFFFFFFFF),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF).withOpacity(0.3),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 32.h),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF888888),
          ),
          isDense: true,
          counterText: '',
          errorStyle: const TextStyle(fontSize: 0),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.h),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.h),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.h),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.h),
          ),
        )
      ),
    );
  }
}