import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors/app_colors.dart';

class GlobalTextField extends StatefulWidget {
  const GlobalTextField({
    Key? key,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    required this.textAlign,
    required this.controller,
    this.icon,
    required this.maxLines,
  }) : super(key: key);

  final String hintText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final TextEditingController controller;
  final int maxLines;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.brown,
          fontFamily: "Montserrat"),
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: Icon(
                widget.icon,
                color: AppColors.c_111015,
              ),
        filled: true,
        fillColor: AppColors.white,
        hintText: widget.hintText,
        hintStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.brown.withOpacity(0.7),
            fontFamily: "Montserrat"),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: Colors.brown,
            )),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.brown,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.brown,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.brown,
          ),
        ),
      ),
    );
  }
}
