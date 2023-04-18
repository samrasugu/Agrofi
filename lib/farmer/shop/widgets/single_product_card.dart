import 'package:flutter/material.dart';

class SingleProductCard extends StatelessWidget {
  final String image;
  const SingleProductCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(
            5,
          ),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            5,
          ),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            width: 100,
            height: 80,
          ),
        ),
      ),
    );
  }
}
