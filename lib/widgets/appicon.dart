import 'package:ecommirce/utils/colors.dart';
import 'package:ecommirce/utils/diminthions.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundcolor;

  final Color iconcolor;
  final double size;
final double iconsize;
  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundcolor =  Colors.white,
    this.size = 40,
    this.iconcolor = const Color(0XFF756d54),
    this.iconsize=16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2), color: backgroundcolor,
      ),

      child: Icon(
        icon,
        color: iconcolor,
        size: iconsize,
      ),
    );
  }
}
