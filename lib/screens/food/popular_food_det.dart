import 'package:ecommirce/controllers/cart_controller.dart';
import 'package:ecommirce/controllers/popular_product_controller.dart';
import 'package:ecommirce/screens/food/cart_page.dart';
import 'package:ecommirce/screens/home/main_food_bage.dart';
import 'package:ecommirce/utils/app_constans.dart';
import 'package:ecommirce/utils/diminthions.dart';
import 'package:ecommirce/widgets/app_column.dart';
import 'package:ecommirce/widgets/appicon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandaple_text.dart';
import '../../widgets/icon_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {  int pageId;
final String page;
  PopularFoodDetail({Key? key, required this.pageId,required this.page}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularproductlist[pageId];
    Get.find<PopularProductController>().initProduct(product,
        Get.find<CartController>()); //اول لما ادخل البرودكت ترن الفانكشن دي
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimentions.popularfoodimgsiz,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstans.BASE_URL +
                          AppConstans.UPLOAD_URL +
                          product.img!,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: Dimentions.height45,
              left: Dimentions.width20,
              right: Dimentions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(page=="cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else {
                        Get.toNamed(RouteHelper.getInitial());
                      }

                    },
                    child: AppIcon(
                      icon: Icons.arrow_back,
                    ),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return   GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [

                             AppIcon(icon: Icons.shopping_cart_outlined),

                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconcolor: Colors.transparent,
                                    backgroundcolor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 5,
                                  top: 1,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: Dimentions.width15,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: Dimentions.popularfoodimgsiz - 20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimentions.width20,
                  right: Dimentions.width20,
                  top: Dimentions.height20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimentions.redius20),
                    topLeft: Radius.circular(Dimentions.redius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(
                      height: Dimentions.height20,
                    ),
                    BigText(
                      text: "Introduction",
                    ),
                    SizedBox(
                      height: Dimentions.height5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(text: product.description!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularproduct) {
            return Container(
              height: Dimentions.bottomgeightbar,
              padding: EdgeInsets.only(
                  top: Dimentions.height30,
                  bottom: Dimentions.height30,
                  right: Dimentions.height20,
                  left: Dimentions.height20),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimentions.redius20 * 2),
                  topRight: Radius.circular(Dimentions.redius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimentions.height20,
                        bottom: Dimentions.height20,
                        left: Dimentions.width20,
                        right: Dimentions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.redius20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            popularproduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                        BigText(
                          text: popularproduct.inCardItems.toString(),
                        ),
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularproduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularproduct.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: Dimentions.width20,
                          right: Dimentions.width20,
                          top: Dimentions.height20,
                          bottom: Dimentions.height20),
                      child: BigText(
                        text: "\$ ${product.price!} " + "| Add to cart",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimentions.redius20),
                          color: AppColors.mainColor),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
