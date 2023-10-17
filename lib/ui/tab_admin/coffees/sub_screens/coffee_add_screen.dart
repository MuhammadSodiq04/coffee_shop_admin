import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_shop_admin/data/model/coffee_model.dart';
import 'package:coffee_shop_admin/data/provider/coffee_provider.dart';
import 'package:coffee_shop_admin/utils/ui_utils/constants.dart';
import 'package:coffee_shop_admin/utils/ui_utils/global_button.dart';
import 'package:coffee_shop_admin/utils/ui_utils/global_text_fields.dart';
import 'package:coffee_shop_admin/utils/ui_utils/shimmer_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CoffeeAddScreen extends StatefulWidget {
  const CoffeeAddScreen({super.key, this.coffeeModel});

  final CoffeeModel? coffeeModel;

  @override
  State<CoffeeAddScreen> createState() => _CoffeeAddScreenState();
}

class _CoffeeAddScreenState extends State<CoffeeAddScreen> {
  @override
  void initState() {
    if (widget.coffeeModel != null) {
      context.read<CoffeeProvider>().updateControllers(widget.coffeeModel!);
    } else {
      context.read<CoffeeProvider>().clearParameters();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<CoffeeProvider>(context, listen: false).clearParameters();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.brown),
          backgroundColor: Colors.brown,
          title: Text(
            widget.coffeeModel == null ? "Coffee Add" : "Coffee Update",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 24.sp,
              fontFamily: "Montserrat",
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                children: [
                  GlobalTextField(
                    hintText: "Coffee Name",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller:
                        context.read<CoffeeProvider>().coffeeNameController,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 200,
                    child: GlobalTextField(
                        maxLines: 100,
                        hintText: "Description",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        controller: context
                            .read<CoffeeProvider>()
                            .coffeeDescController),
                  ),
                  GlobalTextField(
                    hintText: "Coffee Price",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller:
                        context.read<CoffeeProvider>().coffeePriceController,
                    maxLines: 1,
                  ),
                  context.watch<CoffeeProvider>().uploadedImagesUrls.isEmpty
                      ? TextButton(
                          onPressed: () {
                            showBottomSheetDialog();
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.brown,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                          child: Text(
                            "Select Image",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CachedNetworkImage(
                            imageUrl: context
                                .read<CoffeeProvider>()
                                .uploadedImagesUrls
                                .first,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const ShimmerPhoto(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ),
                  Visibility(
                      visible: context
                          .watch<CoffeeProvider>()
                          .uploadedImagesUrls
                          .isNotEmpty,
                      child: TextButton(
                        onPressed: () {
                          context.read<CoffeeProvider>().clearSelectImage();
                        },
                        style:
                            TextButton.styleFrom(
                                backgroundColor: Colors.brown,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                        child: Text(
                          "Delete Image",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ))
                ].divide(SizedBox(height: 20.h,)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
              child: GlobalButton(
                  title: widget.coffeeModel == null
                      ? "Add Coffee"
                      : "Update Coffee",
                  onTap: () {
                    if (context
                            .read<CoffeeProvider>()
                            .uploadedImagesUrls
                            .isNotEmpty &&
                        context
                            .read<CoffeeProvider>()
                            .coffeeNameController
                            .text
                            .isNotEmpty &&
                        context
                            .read<CoffeeProvider>()
                            .coffeePriceController
                            .text
                            .isNotEmpty &&
                        context
                            .read<CoffeeProvider>()
                            .coffeeDescController
                            .text
                            .isNotEmpty) {
                      if (widget.coffeeModel == null) {
                        context
                            .read<CoffeeProvider>()
                            .addCoffee(context: context);
                      } else {
                        context.read<CoffeeProvider>().updateCoffee(
                            context: context, coffeeModel: widget.coffeeModel!);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 500),
                          backgroundColor: Colors.red,
                          margin: EdgeInsets.symmetric(
                            vertical: 70,
                            horizontal: 20,
                          ),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Ma'lumotlar to'liq emas!!!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  context.read<CoffeeProvider>().getFromGallery(context);
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.photo,
                  color: Colors.white,
                ),
                title: Text("Select from Gallery",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp)),
              ),
              ListTile(
                onTap: () {
                  context.read<CoffeeProvider>().getFromCamera(context);
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                ),
                title: Text("Select from Camera",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp)),
              )
            ],
          ),
        );
      },
    );
  }
}
