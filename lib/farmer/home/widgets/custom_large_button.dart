import 'package:agrofi/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomLargeButton extends StatelessWidget {
  final IconData? icon;
  final String maintext;
  final String subtext;
  const CustomLargeButton(
      {super.key, this.icon, required this.maintext, required this.subtext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.width * 0.425,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 38,
                color: GlobalVariables.primaryColor,
              ),
              Text(
                maintext,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
              ),
              Text(
                subtext,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w100
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
