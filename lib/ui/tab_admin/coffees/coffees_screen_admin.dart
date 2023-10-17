import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_shop_admin/data/model/coffee_model.dart';
import 'package:coffee_shop_admin/data/provider/coffee_provider.dart';
import 'package:coffee_shop_admin/ui/route/route_names.dart';
import 'package:coffee_shop_admin/utils/ui_utils/shimmer_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CoffeeScreenAdmin extends StatefulWidget {
  const CoffeeScreenAdmin({super.key});

  @override
  State<CoffeeScreenAdmin> createState() => _CoffeeScreenAdminState();
}

class _CoffeeScreenAdminState extends State<CoffeeScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.brown),
        backgroundColor: Colors.brown,
        title: Text("Coffee Admin",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 24.sp,
            fontFamily: "Montserrat",
          ),),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.coffeeAdd);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<CoffeeModel>>(
        stream: context.read<CoffeeProvider>().getCoffees(),
        builder: (BuildContext context, AsyncSnapshot<List<CoffeeModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
              children: List.generate(
                snapshot.data!.length,
                    (index) {
                  CoffeeModel coffeeModel = snapshot.data![index];
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (v){
                      context.read<CoffeeProvider>().deleteCoffee(
                        context: context,
                        coffeeId: coffeeModel.coffeeId,
                      );
                    },
                    child: ListTile(
                      leading: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: CachedNetworkImage(
                              imageUrl: coffeeModel.coffeeImages[0],
                              placeholder: (context, url) => const ShimmerPhoto(),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error,
                                  color: Colors.red),
                              width: 140.w,
                              fit: BoxFit.cover
                          )),
                      title: Text(coffeeModel.coffeeName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.brown,
                          fontSize: 17.sp,
                          fontFamily: "Montserrat",
                        ),),
                      subtitle: Text(coffeeModel.description,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.brown,
                          fontSize: 15.sp,
                          fontFamily: "Montserrat",
                        ),),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteNames.coffeeAdd,arguments: coffeeModel);
                        },
                        icon: const Icon(Icons.edit, color: Colors.brown),
                      ),
                    ),
                  );
                },
              ),
            )
                : const Center(child: Text("Coffee Empty!"));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator(color: Colors.brown,));
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
