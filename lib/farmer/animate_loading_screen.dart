import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationLoadingScreen extends StatelessWidget {
  const AnimationLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Image(
                image: AssetImage('assets/agrofi_logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Lottie.asset(
              "assets/icons/129793-afro-man-farmer-online-agriculture-service-application-wheat-fields-growth.json",
            ),
          ],
        ),
      ),
    );
  }
}
