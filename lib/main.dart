import 'package:coffee_shop_admin/data/cubit/tab_cubit.dart';
import 'package:coffee_shop_admin/data/provider/coffee_provider.dart';
import 'package:coffee_shop_admin/data/provider/order_provider.dart';
import 'package:coffee_shop_admin/data/servise/orders_service.dart';
import 'package:coffee_shop_admin/ui/route/route_names.dart';
import 'package:coffee_shop_admin/ui/route/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'data/servise/coffee_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signInAnonymously();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TabBoxClientCubit>(
        lazy: true,
        create: (context) => TabBoxClientCubit(),
      ),
    ],
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CoffeeProvider(coffeeService: CoffeeService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(orderService: OrderService()),
          lazy: true,
        ),
      ],
      child: const MainApp(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MaterialApp(
            initialRoute: RouteNames.splash,
            onGenerateRoute: AppRoute.generateRoute,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
