import 'package:coffee_shop_admin/data/model/basket_model.dart';
import 'package:coffee_shop_admin/data/provider/order_provider.dart';
import 'package:coffee_shop_admin/utils/ui_utils/constants.dart';
import 'package:coffee_shop_admin/utils/ui_utils/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showGlobalAlertDialog(
    BuildContext context, BasketModel basketModel, bool isInfo) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            title: Text(
              isInfo ? "Client info" : "Select status",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.brown,
                fontSize: 18.sp,
                fontFamily: "Montserrat",
              ),
            ),
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: isInfo
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          basketModel.userName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.brown,
                            fontSize: 18.sp,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        Text(
                          basketModel.userPhone,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.brown,
                            fontSize: 18.sp,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        Text(
                          basketModel.userAddress,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.brown,
                            fontSize: 18.sp,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        Text(
                          basketModel.createdAt,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.brown,
                            fontSize: 18.sp,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 150.w,
                              height: 40.h,
                              child: GlobalButton(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  title:
                                    "OK",
                                  ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(
                        height: 10.h,
                      )),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 150.w,
                          height: 40.h,
                          child: GlobalButton(
                            onTap: () {
                              context.read<OrderProvider>().updateOrder(
                                  context: context,
                                  orderModel: basketModel.copWith(
                                      orderStatus: "accepted"));
                            },
                            title: "Accepted",
                          ),
                        ),
                        SizedBox(
                            width: 150.w,
                            height: 40.h,
                            child: GlobalButton(
                              onTap: () {
                                context.read<OrderProvider>().updateOrder(
                                    context: context,
                                    orderModel: basketModel.copWith(
                                        orderStatus: "in progress"));
                              },
                              title: "In progress",
                            )),
                        SizedBox(
                            width: 150.w,
                            height: 40.h,
                            child: GlobalButton(
                              title: "On way",
                              onTap: () {
                                context.read<OrderProvider>().updateOrder(
                                    context: context,
                                    orderModel: basketModel.copWith(
                                        orderStatus: "on way"));
                              },
                            )),
                        SizedBox(
                            width: 150.w,
                            height: 40.h,
                            child: GlobalButton(
                              title: "Delivered",
                              onTap: () {
                                context.read<OrderProvider>().updateOrder(
                                    context: context,
                                    orderModel: basketModel.copWith(
                                        orderStatus: "delivered"));
                              },
                            )),
                        SizedBox(
                            width: 150.w,
                            height: 40.h,
                            child: GlobalButton(
                              title: "Cancel",
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )),
                      ].divide(SizedBox(
                        height: 10.h,
                      )),
                    ),
            ),
          ),
        );
      });
}
