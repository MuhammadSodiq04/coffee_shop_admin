import 'package:coffee_shop_admin/data/cubit/tab_cubit.dart';
import 'package:coffee_shop_admin/ui/tab_admin/basket/basket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'coffees/coffees_screen_admin.dart';

class TabBoxAdmin extends StatelessWidget {
  TabBoxAdmin({Key? key}) : super(key: key);

  final List<Widget> screens = [
    const CoffeeScreenAdmin(),
    const BasketScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[context.watch<TabBoxClientCubit>().index], // Watch the current index from the Cubit
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(size: 40.r, color: Colors.white),
        unselectedIconTheme: IconThemeData(size: 30.r, color: Colors.grey),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.brown,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Colors.white), label: ''),
        ],
        currentIndex: context.watch<TabBoxClientCubit>().index, // Watch the current index from the Cubit
        onTap: (index) => context.read<TabBoxClientCubit>().changeTab(index), // Use the Cubit to change the tab
      ),
    );
  }
}
