import 'package:agrofi/auth/screens/register_screen.dart';
import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/auth/services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  late String phoneNumber;
  final TextEditingController pinNumberController = TextEditingController();

  String? pin;

  final AuthService authService = AuthService();

  bool passwordvisible = true;

  String initialCountry = "KE";
  PhoneNumber number = PhoneNumber(isoCode: "KE");

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    pinNumberController.dispose();
  }

  void signIn() async {
    String? deviceToken = await _firebaseMessaging.getToken();
    if (mounted) {
      authService.signIn(
        context: context,
        phoneNumber: phoneNumber,
        pin: pinNumberController.text,
        deviceToken: deviceToken!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
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
                const Text(
                  "Login",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          // print(number.phoneNumber);
                          setState(() {
                            phoneNumber = number.phoneNumber.toString();
                          });
                        },
                        onInputValidated: (bool value) {
                          // print(value);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          leadingPadding: 9.0,
                          setSelectorButtonAsPrefixIcon: true,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        // textFieldController: phoneNumberController,
                        formatInput: true,
                        hintText: '712345678',
                        textStyle: const TextStyle(fontSize: 14),
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        inputDecoration: InputDecoration(
                          contentPadding: EdgeInsetsGeometry.lerp(
                            const EdgeInsets.all(17),
                            const EdgeInsets.all(17),
                            17,
                          ),
                          hintText: '712345678',
                          hintStyle: const TextStyle(fontSize: 16),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                            // gapPadding: 4.0,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                        ),
                        inputBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        onSaved: (PhoneNumber number) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: passwordvisible,
                        controller: pinNumberController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onSaved: (String? newValue) {
                          pin = newValue;
                        },
                        decoration: InputDecoration(
                          hintText: "Pin",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                          ),
                          contentPadding: EdgeInsetsGeometry.lerp(
                            const EdgeInsets.all(17),
                            const EdgeInsets.all(17),
                            17,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordvisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: GlobalVariables.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordvisible = !passwordvisible;
                              });
                            },
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "PIN Number required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: CustomButton(
                          text: "Login",
                          color: GlobalVariables.primaryColor,
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signIn();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RegisterScreen.routeName,
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
