import 'package:coffee_shop_admin/data/model/basket_model.dart';
import 'package:coffee_shop_admin/data/provider/order_provider.dart';
import 'package:coffee_shop_admin/utils/ui_utils/global_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("Basket Admin",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 24.sp,
            fontFamily: "Montserrat",
          ),),
      ),
      body: StreamBuilder<List<BasketModel>>(
        stream: context.read<OrderProvider>().listenOrdersList(FirebaseAuth.instance.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<List<BasketModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
                    children: List.generate(
                      snapshot.data!.length,
                      (index) {
                        BasketModel basketModel = snapshot.data![index];
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (v) {
                            context.read<OrderProvider>().deleteOrder(
                                context: context, orderId: basketModel.orderId);
                          },
                          child: ListTile(
                            onLongPress: (){
                              showGlobalAlertDialog(context, basketModel,true);
                            },
                            onTap: () {
                              showGlobalAlertDialog(context, basketModel,false);
                            },
                            title: Text(basketModel.coffeeName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.brown,
                                fontSize: 18.sp,
                                fontFamily: "Montserrat",
                              ),),
                            subtitle: Text("${basketModel.count} = ${basketModel.totalPrice} so'm",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.brown,
                                fontSize: 15.sp,
                                fontFamily: "Montserrat",
                              ),),
                            trailing: Text(basketModel.orderStatus,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.brown,
                                fontSize: 15.sp,
                                fontFamily: "Montserrat",
                              ),),
                          ),
                        );
                      },
                    ),
                  )
                : const Center(child: Text("Basket Empty!"));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator(color: Colors.brown,));
        },
      ),
    );
  }
}
