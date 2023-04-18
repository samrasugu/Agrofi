import 'package:agrofi/auth/services/auth_service.dart';
import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/models/user.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PhoneVerificationScreen extends StatefulWidget {
  static const String routeName = "/phone-verification-screen";
  const PhoneVerificationScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  bool isLoading = false;
  bool isResend = false;

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 5), () {
    //   setState(() {
    //     isResend = true;
    //   });
    // });
    Future.delayed(Duration.zero, () async {});
  }

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FirebasePhoneAuthHandler(
        phoneNumber: widget.user.phoneNumber,
        signOutOnSuccessfulVerification: true,
        builder: (context, controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 104,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    const Text(
                      "Enter your verification code",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Enter the 6 digit code sent to:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.user.phoneNumber,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Pinput(
                      onCompleted: (pin) async {
                        setState(() {
                          isLoading = true;
                        });
                        final isCorrect = await controller.verifyOtp(pin);
                        if (isCorrect) {
                          try {
                            if (mounted) {
                              await authService.signUpUser(
                                context: context,
                                firstName: widget.user.firstName,
                                lastName: widget.user.lastName,
                                phoneNumber: widget.user.phoneNumber,
                                pin: widget.user.pin,
                              );
                            }
                          } catch (e) {
                            if (mounted) {}
                            showSnackBar(context, e.toString());
                          }
                        } else {
                          // setState(() {
                          //   isLoading = false;
                          // });
                          if (mounted) {
                            showSnackBar(context, "Incorrect OTP");
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsRetrieverApi,
                      listenForMultipleSmsOnAndroid: true,
                      length: 6,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Didn't receive the code?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Resend code in '),
                        Text(
                          controller.autoRetrievalTimeLeft.toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomButton(
                  text: 'Resend code',
                  // isLoading: isLoading,
                  color: GlobalVariables.primaryColor,
                  onTap: () async {
                    controller.autoRetrievalTimeLeft.inSeconds < 1
                        ? controller.sendOTP()
                        : ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please wait for the code to be sent',
                              ),
                            ),
                          );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }
}
