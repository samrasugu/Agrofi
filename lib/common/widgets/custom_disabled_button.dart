import 'package:flutter/material.dart';

class CustomDiabledButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomDiabledButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        disabledBackgroundColor: Colors.grey.shade400,
        backgroundColor: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? Colors.black : Colors.black,
        ),
      ),
    );
  }
}