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
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.425,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow:  [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  border: Border.all(
                    color: GlobalVariables.greyBackGround,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  icon,
                  size: 38,
                  color: GlobalVariables.primaryColor,
                ),
              ),
              Text(
                maintext,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
