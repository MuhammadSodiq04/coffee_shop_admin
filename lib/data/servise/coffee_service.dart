import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_admin/data/model/coffee_model.dart';
import 'package:coffee_shop_admin/data/model/universal_data.dart';
import 'package:coffee_shop_admin/utils/ui_utils/constants.dart';

class CoffeeService{
  Future<UniversalData> addCoffee({required CoffeeModel coffeeModel}) async {
    try {
      DocumentReference newProduct = await FirebaseFirestore.instance
          .collection(firebaseCollectionName)
          .add(coffeeModel.toJson());

      await FirebaseFirestore.instance
          .collection(firebaseCollectionName)
          .doc(newProduct.id)
          .update({
        "coffeeId": newProduct.id,
      });

      return UniversalData(data: "Coffee added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateProduct(
      {required CoffeeModel coffeeModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection(firebaseCollectionName)
          .doc(coffeeModel.coffeeId)
          .update(coffeeModel.toJson());

      return UniversalData(data: "Coffee updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteCoffee({required String coffeeId}) async {
    try {
      await FirebaseFirestore.instance
          .collection(firebaseCollectionName)
          .doc(coffeeId)
          .delete();

      return UniversalData(data: "Coffee deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
