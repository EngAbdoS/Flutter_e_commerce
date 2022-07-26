import 'package:ecommirce/controllers/popular_product_controller.dart';
import 'package:ecommirce/controllers/recommended_controler.dart';
import 'package:ecommirce/routes/route_helper.dart';
import 'package:ecommirce/screens/food/cart_page.dart';
import 'package:ecommirce/utils/app_constans.dart';
import 'package:ecommirce/utils/colors.dart';
import 'package:ecommirce/utils/diminthions.dart';
import 'package:ecommirce/widgets/appicon.dart';
import 'package:ecommirce/widgets/big_text.dart';
import 'package:ecommirce/widgets/expandaple_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
final String page;
  RecommendedFoodDetail({Key? key, required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recomendedproductlist[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if(page=="cartpage"){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else {
                      Get.toNamed(RouteHelper.getInitial());
                    }                  },
                  child: AppIcon(
                    icon: Icons.clear,
                  ),
                ),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.redius20),
                    topRight: Radius.circular(Dimentions.redius20),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: BigText(
                    text: product.name!,
                    size: Dimentions.font26,
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstans.BASE_URL + AppConstans.UPLOAD_URL + product.img!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                child: ExpandableText(
                  text: product.description!,
                ),
                margin: EdgeInsets.only(
                    left: Dimentions.width20, right: Dimentions.width20),
              )
            ],
          )),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimentions.width20 * 2.5,
                    right: Dimentions.width20 * 2.5,
                    top: Dimentions.height10,
                    bottom: Dimentions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        iconcolor: Colors.white,
                        backgroundcolor: AppColors.mainColor,
                        icon: Icons.remove, //size: Dimentions.icon24,
                      ),
                    ),
                    BigText(
                      text: "\$ ${product.price!}" +
                          "  X " +
                          "${controller.inCardItems}",
                      color: AppColors.mainBlackColor,
                      size: Dimentions.font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);

                        print("i am tapped");
                      },
                      child: AppIcon(
                        iconcolor: Colors.white,
                        backgroundcolor: AppColors.mainColor,
                        icon: Icons.add,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                        borderRadius:
                            BorderRadius.circular(Dimentions.redius20),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: Dimentions.width20,
                            right: Dimentions.width20,
                            top: Dimentions.height20,
                            bottom: Dimentions.height20),
                        child: BigText(
                          text: "\$ ${product.price!} | Add to card",
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimentions.redius20),
                            color: AppColors.mainColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
