import 'package:agrofi/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData leadingIcon;
  final IconData trailingIcon;
  final String title;
  final VoidCallback onTap;
  const CustomListTile({super.key, required this.leadingIcon, required this.trailingIcon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: GlobalVariables.primaryColor,
      ),
      title: Text(
        title,
        textScaleFactor: 1.5,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        ),
        trailing: Icon(
          trailingIcon,
          color: GlobalVariables.primaryColor,
        ),
        onTap: onTap,
    );
  }
}