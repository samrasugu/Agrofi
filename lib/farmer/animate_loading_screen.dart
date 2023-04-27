import 'package:agrofi/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
