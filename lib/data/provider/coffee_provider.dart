import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_admin/data/model/coffee_model.dart';
import 'package:coffee_shop_admin/data/model/universal_data.dart';
import 'package:coffee_shop_admin/data/servise/coffee_service.dart';
import 'package:coffee_shop_admin/data/servise/upload_service.dart';
import 'package:coffee_shop_admin/utils/ui_utils/constants.dart';
import 'package:coffee_shop_admin/utils/ui_utils/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CoffeeProvider with ChangeNotifier{
  CoffeeProvider({required this.coffeeService});

  final CoffeeService coffeeService;

  TextEditingController coffeeNameController = TextEditingController();
  TextEditingController coffeePriceController = TextEditingController();
  TextEditingController coffeeDescController = TextEditingController();

  List<dynamic> uploadedImagesUrls = [];
  ImagePicker picker = ImagePicker();

  void updateControllers(CoffeeModel coffeeModel){
    coffeeNameController = TextEditingController(text: coffeeModel.coffeeName);
    coffeeDescController = TextEditingController(text: coffeeModel.description);
    coffeePriceController = TextEditingController(text: coffeeModel.price.toString());
    uploadedImagesUrls = coffeeModel.coffeeImages;
  }


  Future<void> getFromGallery(BuildContext context) async {
    showLoading(context: context);
    List<XFile?> xFiles = await picker.pickMultiImage(
      maxHeight: 512,
      maxWidth: 512,
    );
    if (context.mounted) {
      await uploadCoffeeImages(context: context, images: xFiles);
    }
  }

  Future<void> getFromCamera(BuildContext context) async {
    showLoading(context: context);
    List<XFile?> xFile = [
      await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 512,
        maxWidth: 512,
      )
    ];
    if (context.mounted) {
      await uploadCoffeeImages(
        context: context,
        images: xFile,
      );
    }
  }

  Future<void> addCoffee({
    required BuildContext context,
  }) async {

      CoffeeModel coffeeModel = CoffeeModel(
        price: int.parse(coffeePriceController.text),
        coffeeImages: uploadedImagesUrls,
        coffeeId: "",
        coffeeName: coffeeNameController.text,
        description: coffeeDescController.text,
        createdAt: DateTime.now().toString(),
      );

      showLoading(context: context);
      UniversalData universalData = await coffeeService.addCoffee(coffeeModel: coffeeModel);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
          clearParameters();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
  }

  Future<void> deleteCoffee({
    required BuildContext context,
    required String coffeeId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
    await coffeeService.deleteCoffee(coffeeId: coffeeId);
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

  Stream<List<CoffeeModel>> getCoffees() async* {
      yield* FirebaseFirestore.instance.collection(firebaseCollectionName).snapshots().map(
            (event1) => event1.docs
            .map((doc) => CoffeeModel.fromJson(doc.data()))
            .toList(),
      );
  }

  Future<void> updateCoffee({
    required BuildContext context,
    required CoffeeModel coffeeModel,
  }) async {
      showLoading(context: context);
      UniversalData universalData = await coffeeService.updateProduct(
        coffeeModel: CoffeeModel(
          price: int.parse(coffeePriceController.text),
          coffeeImages: uploadedImagesUrls,
          createdAt: coffeeModel.createdAt,
          coffeeName: coffeeNameController.text,
          description: coffeePriceController.text,
          coffeeId: coffeeModel.coffeeId,
        ),
      );
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
      clearParameters();
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

  Future<void> uploadCoffeeImages({
    required BuildContext context,
    required List<XFile?> images,
  }) async {
    showLoading(context: context);

    for (var element in images) {
      UniversalData data = await FileUploader.imageUploader(element!);
      if (data.error.isEmpty) {
        uploadedImagesUrls.add(data.data as String);
      }
    }

    notifyListeners();

    if (context.mounted) {
      hideLoading(dialogContext: context);
      hideLoading(dialogContext: context);
    }
  }

  clearSelectImage(){
    uploadedImagesUrls = [];
    notifyListeners();
  }

  clearParameters() {
    uploadedImagesUrls = [];
    coffeePriceController.clear();
    coffeeNameController.clear();
    coffeeDescController.clear();
  }
}
