import 'package:ecommirce/controllers/cart_controller.dart';
import 'package:ecommirce/controllers/popular_product_controller.dart';
import 'package:ecommirce/controllers/recommended_controler.dart';
import 'package:ecommirce/utils/app_constans.dart';
import 'package:ecommirce/utils/colors.dart';
import 'package:ecommirce/utils/diminthions.dart';
import 'package:ecommirce/widgets/appicon.dart';
import 'package:ecommirce/widgets/big_text.dart';
import 'package:ecommirce/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../home/main_food_bage.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: Dimentions.width20,
            right: Dimentions.width20,
            top: Dimentions.height30 * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back,
                  iconcolor: Colors.white,
                  backgroundcolor: AppColors.mainColor,
                  iconsize: Dimentions.icon24,
                ),
                SizedBox(
                  width: Dimentions.width40,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconcolor: Colors.white,
                    backgroundcolor: AppColors.mainColor,
                    iconsize: Dimentions.icon24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconcolor: Colors.white,
                  backgroundcolor: AppColors.mainColor,
                  iconsize: Dimentions.icon24,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimentions.height20 * 5,
            left: Dimentions.width20,
            right: Dimentions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimentions.height15),
              //color: Colors.red,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController) {
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          height: 100,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularproductlist
                                          .indexOf(_cartList[index].product!);
                                  if (popularIndex >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFood(
                                        popularIndex, "cartpage"));
                                  } else {
                                    var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recomendedproductlist
                                            .indexOf(_cartList[index].product!);
                                    Get.toNamed(RouteHelper.getRecommendedFood(
                                        recommendedIndex, "cartpage"));
                                  }
                                },
                                child: Container(
                                  width: Dimentions.width20 * 5,
                                  height: Dimentions.height20 * 5,
                                  margin: EdgeInsets.only(
                                      bottom: Dimentions.height10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimentions.redius20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(AppConstans.BASE_URL +
                                          AppConstans.UPLOAD_URL +
                                          cartController.getItems[index].img!),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimentions.height10,
                              ),
                              Expanded(
                                child: Container(
                                  height: Dimentions.height20 * 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text: cartController
                                            .getItems[index].name!,
                                        color: Colors.black45,
                                      ),
                                      SmallText(text: "Spicy"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text: cartController
                                                .getItems[index].price
                                                .toString(),
                                            color: Colors.redAccent,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: Dimentions.height10,
                                                bottom: Dimentions.height10,
                                                left: Dimentions.width10,
                                                right: Dimentions.width10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimentions.redius20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    cartController.addItem(
                                                        _cartList[index]
                                                            .product!,
                                                        -1);
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
                                                    text: _cartList[index]
                                                        .quantity!
                                                        .toString()
                                                    //popularproduct.inCardItems.toString(),
                                                    ),
                                                SizedBox(
                                                  width: Dimentions.width5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    cartController.addItem(
                                                        _cartList[index]
                                                            .product!,
                                                        1);
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: AppColors.signColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cart) {
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

                      SizedBox(
                        width: Dimentions.width5,
                      ),
                      BigText(
                        text: "\$ "+cart.totalAmount.toString(),color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: Dimentions.width5,
                      ),

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
cart.addToHistory();

                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: Dimentions.width20,
                        right: Dimentions.width20,
                        top: Dimentions.height20,
                        bottom: Dimentions.height20),
                    child: BigText(
                      text: "Check out",
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
      ),
    );
  }
}
