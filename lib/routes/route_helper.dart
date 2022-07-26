import 'package:ecommirce/screens/aplash/spilasg_page.dart';
import 'package:ecommirce/screens/food/cart_page.dart';
import 'package:ecommirce/screens/food/popular_food_det.dart';
import 'package:ecommirce/screens/food/recommended_food.dart';
import 'package:ecommirce/screens/home/main_food_bage.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/home/hame_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularfood = "/popular-food"; //should have / to work
  static const String recommendedfood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getInitial() => "$initial";

  static String getSplashPage() => "$splashPage";

  static String getPopularFood(int pageId, String page) =>
      '$popularfood?pageId=$pageId&page=$page';

  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedfood?pageId=$pageId&page=$page';

  static String getCartPage() => '$cartPage';
  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => HomePage(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
        name: popularfood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 300)),
    GetPage(
      name: recommendedfood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters["page"];

        return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: splashPage,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300),
    )
  ];
}
