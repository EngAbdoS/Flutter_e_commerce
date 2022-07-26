import 'package:ecommirce/utils/diminthions.dart';
import 'package:ecommirce/widgets/small_text.dart';
import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconcolor;

  const IconAndText({
    Key? key,
    required this.text,
    required this.icon,
    required this.iconcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color:  iconcolor,size: Dimentions.icon24,),
        SizedBox(width: Dimentions.width5,),
        SmallText(text: text,),

      ],
    );
  }
}
