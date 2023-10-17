import 'package:coffee_shop_admin/ui/route/route_names.dart';
import 'package:coffee_shop_admin/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 3));
    if (context.mounted) {
      Navigator.pushReplacementNamed(
        context,RouteNames.tabBox);
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10.r),
        child: Center(
          child: Image.asset(AppImages.coffeeLogo,color: Colors.brown,),
        ),
      ),
    );
  }
}
