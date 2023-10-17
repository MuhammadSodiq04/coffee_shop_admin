import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_admin/data/model/basket_model.dart';
import 'package:coffee_shop_admin/data/model/universal_data.dart';
import 'package:coffee_shop_admin/data/servise/orders_service.dart';
import 'package:coffee_shop_admin/utils/ui_utils/constants.dart';
import 'package:coffee_shop_admin/utils/ui_utils/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderProvider with ChangeNotifier {
  OrderProvider({required this.orderService}) {
    listenOrders(FirebaseAuth.instance.currentUser!.uid);
  }

  final OrderService orderService;
  List<BasketModel> userOrders = [];

  Future<void> addOrder({
    required BuildContext context,
    required BasketModel orderModel,
  }) async {
    List<BasketModel> exists = userOrders
        .where((element) => element.coffeeId == orderModel.coffeeId)
        .toList();

    BasketModel? oldOrderModel;
    if (exists.isNotEmpty) {
      oldOrderModel = exists.first;
      oldOrderModel = oldOrderModel.copWith(
          count: orderModel.count + oldOrderModel.count,
          totalPrice:
              (orderModel.count + oldOrderModel.count) * orderModel.totalPrice);
    }

    showLoading(context: context);
    UniversalData universalData = exists.isNotEmpty
        ? await orderService.updateOrder(orderModel: oldOrderModel!)
        : await orderService.addOrder(orderModel: orderModel);

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
        Navigator.pop(context);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateOrder({
    required BuildContext context,
    required BasketModel orderModel,
  }) async {
    showLoading(context: context);

    UniversalData universalData =
        await orderService.updateOrder(orderModel: orderModel);

    if (context.mounted) {
      hideLoading(dialogContext: context);
      Navigator.pop(context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> deleteOrder({
    required BuildContext context,
    required String orderId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await orderService.deleteOrder(orderId: orderId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<BasketModel>> listenOrdersList(String? uid) async* {
      yield* FirebaseFirestore.instance.collection(firebaseOrderName).snapshots().map(
            (event1) => event1.docs
                .map((doc) => BasketModel.fromJson(doc.data()))
                .toList(),
          );
  }

  listenOrders(String userId) async {
    listenOrdersList(userId).listen((List<BasketModel> orders) {
      userOrders = orders;
      debugPrint("CURRENT USER ORDERS LENGTH:${userOrders.length}");
      notifyListeners();
    });
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error, style: TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontSize: 16.sp,
      fontFamily: "Montserrat",
    ),),backgroundColor: Colors.brown,));
    notifyListeners();
  }
}
