import 'package:ecommirce/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/diminthions.dart';
import 'big_text.dart';
import 'icon_text.dart';
class AppColumn extends StatelessWidget {
  final String text;





  const AppColumn({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text:text,size:  Dimentions.font26,),
        SizedBox(
          height: Dimentions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                    (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimentions.icon15,
                ),
              ),
            ),
            SizedBox(
              width: Dimentions.width10,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: Dimentions.width10,
            ),
            SmallText(text: "1287"),
            SizedBox(
              width: Dimentions.width10,
            ),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(
          height: Dimentions.width20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                icon: Icons.access_time_filled_rounded,
                iconcolor: AppColors.iconColor2)
          ],
        ),
      ],
    );
  }
}
