import 'package:ecommirce/controllers/cart_controller.dart';
import 'package:ecommirce/controllers/popular_product_controller.dart';
import 'package:ecommirce/routes/route_helper.dart';
import 'package:ecommirce/screens/aplash/spilasg_page.dart';
import 'package:ecommirce/screens/food/cart_page.dart';
import 'package:ecommirce/screens/food/popular_food_det.dart';
import 'package:ecommirce/screens/food/recommended_food.dart';
import 'package:ecommirce/screens/home/food_page_body.dart';
import 'package:ecommirce/screens/home/main_food_bage.dart';
import 'package:ecommirce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/recommended_controler.dart';
import 'helper/dependences.dart' as dep; //?

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            color: AppColors.mainColor,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            //  home:  SplashScreen(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
