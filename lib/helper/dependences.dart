import 'package:ecommirce/controllers/cart_controller.dart';
import 'package:ecommirce/controllers/popular_product_controller.dart';
import 'package:ecommirce/data/api/api_client.dart';
import 'package:ecommirce/data/repesetory/card_repo.dart';
import 'package:ecommirce/utils/app_constans.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/recommended_controler.dart';
import '../data/repesetory/popural_prudect_repo.dart';
import '../data/repesetory/recommended_product_repo.dart';

Future<void> init() async {
  final sharedPreferences=await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences);

  Get.lazyPut(() => ApiClient(appBaseURL: AppConstans.BASE_URL));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()),);
}
