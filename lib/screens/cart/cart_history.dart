import 'dart:convert';

import 'package:ecommirce/controllers/cart_controller.dart';
import 'package:ecommirce/routes/route_helper.dart';
import 'package:ecommirce/utils/app_constans.dart';
import 'package:ecommirce/utils/diminthions.dart';
import 'package:ecommirce/widgets/appicon.dart';
import 'package:ecommirce/widgets/big_text.dart';
import 'package:ecommirce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/cart_model.dart';
import '../../utils/colors.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemPreOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemPreOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemPreOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemPreOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartitemsPerOrderToList() {
      return cartItemPreOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemPreOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartitemsPerOrderToList();
    var listCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimentions.height20 * 5,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimentions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconcolor: AppColors.mainColor,
                  //backgroundcolor: AppColors.yellowColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(
                    top: Dimentions.height20,
                    left: Dimentions.width20,
                    right: Dimentions.width20),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          height: Dimentions.height20 * 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (() {
                                DateTime parseDate =
                                    DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                        getCartHistoryList[listCounter].time!);
                                var inputDate =
                                    DateTime.parse(parseDate.toString());
                                var outputFormat =
                                    DateFormat("MM/dd/yyyy hh:mm a");
                                var outPutDate = outputFormat.format(inputDate);
                                return BigText(text: outPutDate);
                              }()),
                              SizedBox(
                                height: Dimentions.height10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPerOrder[i],
                                          (index) {
                                        if (listCounter <
                                            getCartHistoryList.length) {
                                          listCounter++;
                                        }

                                        return index <= 2
                                            ? Container(
                                                height: Dimentions.width20 * 4,
                                                width: Dimentions.width20 * 4,
                                                margin: EdgeInsets.only(
                                                    right: Dimentions.width5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimentions
                                                                    .radius15 /
                                                                2),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstans.BASE_URL +
                                                              AppConstans
                                                                  .UPLOAD_URL +
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!),
                                                    )),
                                              )
                                            : Container();
                                      })),
                                  Container(
                                    height: Dimentions.height20 * 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SmallText(
                                          text: "Total",
                                          color: AppColors.titleColor,
                                        ),
                                        BigText(
                                          text: itemsPerOrder[i].toString() +
                                              " Items",
                                          color: AppColors.titleColor,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            var orderTime =
                                                cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder = {};
                                            for (int j = 0;
                                                j < getCartHistoryList.length;
                                                j++) {
                                              if (getCartHistoryList[j].time ==
                                                  orderTime[i]) {
                                                moreOrder.putIfAbsent(
                                                    getCartHistoryList[j].id!,
                                                    () => CartModel.fromJson(
                                                        jsonDecode(jsonEncode(
                                                            getCartHistoryList[
                                                                j]))));
                                              }
                                            }
                                            Get.find<CartController>()
                                                .setItems = moreOrder;
                                            Get.find<CartController>()
                                                .addTOCartList();
                                            Get.toNamed(
                                                RouteHelper.getCartPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimentions.width10,
                                                vertical:
                                                    Dimentions.height10 / 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimentions.radius15 / 3),
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors.mainColor,
                                              ),
                                            ),
                                            child: SmallText(
                                              text: "one more",
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(
                            bottom: Dimentions.height20,
                          ),
                        )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
