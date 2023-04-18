import 'package:agrofi/constants/global_variables.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text),
    backgroundColor: GlobalVariables.primaryColor,
    behavior: SnackBarBehavior.floating,
    elevation: 2.0,
    )
  );
} 