import 'package:ecommirce/controllers/popular_product_controller.dart';
import 'package:ecommirce/controllers/recommended_controler.dart';
import 'package:ecommirce/models/products_model.dart';
import 'package:ecommirce/routes/route_helper.dart';
import 'package:ecommirce/utils/app_constans.dart';
import 'package:ecommirce/utils/colors.dart';
import 'package:ecommirce/utils/diminthions.dart';
import 'package:ecommirce/widgets/app_column.dart';
import 'package:ecommirce/widgets/big_text.dart';
import 'package:ecommirce/widgets/icon_text.dart';
import 'package:ecommirce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController =
      PageController(viewportFraction: 0.85); //الحتة اللي من الجنب
  var currpagevalue = 0.0;
  double scalfactor = 0.8;
  double height = Dimentions.pageviewcontainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currpagevalue = pageController.page!;
        print("current value ");
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose(); //clean memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoaded
                ? Container(
                    // color: Colors.red,
                    height: Dimentions.pageview,

                    child: PageView.builder(

                      controller: pageController,
                      itemBuilder: (context, poition) {
                        return _buildpageitem(
                            poition,
                            popularProducts.popularproductlist[
                                poition]); //object from the list ya r3yek
                      },
                      itemCount: popularProducts.popularproductlist.length,
                    ),
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
        GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return DotsIndicator(
              dotsCount: popularProduct.popularproductlist.length <= 0
                  ? 1
                  : popularProduct.popularproductlist.length,
              position: currpagevalue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimentions.redius5),
                ),
                activeColor: AppColors.mainColor,
              ),
            );
          },
        ),
        SizedBox(
          height: Dimentions.height30,
        ),
        Container(
          margin: EdgeInsets.only(
            left: Dimentions.width30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: "Recommended",
              ),
              SizedBox(
                width: Dimentions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimentions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Food pairing",
                ),
              ),
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: Dimentions.height10,
                          left: Dimentions.width20,
                          right: Dimentions.width20,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: Dimentions.listviewimagesize,
                              height: Dimentions.listviewimagesize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimentions.redius20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      AppConstans.BASE_URL +
                                          AppConstans.UPLOAD_URL +
                                          recommendedProduct
                                              .recomendedproductlist[index]
                                              .img!,
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                height: Dimentions.listviewtextsize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimentions.redius20),
                                    //topLeft:  Radius.circular(Dimentions.redius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimentions.width10,
                                      right: Dimentions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                        text: recommendedProduct
                                            .recomendedproductlist[index].name!,
                                      ),
                                      SizedBox(
                                        height: Dimentions.height10,
                                      ),
                                      SmallText(
                                        text: "With chinese characteristas",
                                      ),
                                      SizedBox(
                                        height: Dimentions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndText(
                                              text: "normal",
                                              icon: Icons.circle_sharp,
                                              iconcolor: AppColors.iconColor1),
                                          IconAndText(
                                              text: "1.7km",
                                              icon: Icons.location_on,
                                              iconcolor: AppColors.mainColor),
                                          IconAndText(
                                              text: "32min",
                                              icon: Icons
                                                  .access_time_filled_rounded,
                                              iconcolor: AppColors.iconColor2)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: recommendedProduct.recomendedproductlist.length,
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
      ],
    );
  }

  Widget _buildpageitem(int index, ProductModel popularproduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == currpagevalue.floor()) {
      var currscale = 1 - (currpagevalue - index) * (1 - scalfactor);
      var currtrans = height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == currpagevalue.floor() + 1) {
      var currscale =
          scalfactor + (currpagevalue - index + 1) * (1 - scalfactor);
      var currtrans = height * (1 - currscale) / 2;

      matrix = Matrix4.diagonal3Values(1, currscale, 1);
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == currpagevalue.floor() - 1) {
      var currscale = 1 - (currpagevalue - index) * (1 - scalfactor);
      var currtrans = height * (1 - currscale) / 2;

      matrix = Matrix4.diagonal3Values(1, currscale, 1);
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currscale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, height * (1 - scalfactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index,"home"));
            },
            child: Container(
              height: Dimentions.pageviewcontainer,
              margin: EdgeInsets.only(
                left: Dimentions.width10,
                right: Dimentions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius30),
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage(
                    AppConstans.BASE_URL +
                        AppConstans.UPLOAD_URL +
                        popularproduct.img!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.pagetextviewcontainer,
              margin: EdgeInsets.only(
                left: Dimentions.width40,
                right: Dimentions.width40,
                bottom: Dimentions.height15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.redius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(0, 5),
                    blurRadius: 5.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimentions.height15,
                  left: Dimentions.width15,
                  right: Dimentions.width15,
                ),
                child: AppColumn(
                  text: popularproduct.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
