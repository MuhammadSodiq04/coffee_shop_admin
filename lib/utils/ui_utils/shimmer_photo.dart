import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPhoto extends StatelessWidget {
  const ShimmerPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.brown,
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.brown,
          ),
        ));
  }
}