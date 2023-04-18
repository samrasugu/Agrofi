import 'package:agrofi/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData? icon;
  final String text;
  final double? width;
  const CustomIcon({
    super.key,
    required this.icon,
    required this.text,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            color: GlobalVariables.greyBackGround,
          ),
          child: Icon(
            icon,
            size: 38,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: GlobalVariables.primaryColor,
            // fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }
}
