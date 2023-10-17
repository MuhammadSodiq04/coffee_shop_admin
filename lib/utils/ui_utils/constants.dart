import 'package:flutter/material.dart';

const String adminEmail = "admin@gmail.com";
const defaultImageConstant = "Select Image";

const firebaseCollectionName = "coffees";
const firebaseOrderName = "orders";

extension WidgetListDivide on List<Widget> {
  List<Widget> divide(Widget divider) {
    List<Widget> dividedList = [];
    for (int i = 0; i < length; i++) {
      dividedList.add(this[i]);
      if (i < length - 1) {
        dividedList.add(divider);
      }
    }
    return dividedList;
  }
}