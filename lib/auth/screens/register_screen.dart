import 'package:agrofi/auth/screens/login_screen.dart';
import 'package:agrofi/auth/screens/phone_verification_screen.dart';
import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/common/widgets/custom_textfield.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register-screen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController pinNumberController = TextEditingController();
  final TextEditingController confirmPinNumberController =
      TextEditingController();

  String? phoneNumber;

  bool passwordvisible = true;

  String? pin;

  String initialCountry = "KE";
  PhoneNumber number = PhoneNumber(isoCode: "KE");

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    idNumberController.dispose();
    pinNumberController.dispose();
    confirmPinNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
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
                // const Text(
                //   "Register",
                //   style: TextStyle(color: Colors.black, fontSize: 20),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: firstNameController,
                        hintText: "First Name",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: lastNameController,
                        hintText: "Last Name",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          // print(number.phoneNumber);
                          setState(() {
                            phoneNumber = number.phoneNumber;
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
                        textFieldController: phoneNumberController,
                        formatInput: true,
                        inputDecoration: InputDecoration(
                          contentPadding: EdgeInsetsGeometry.lerp(
                            const EdgeInsets.all(17),
                            const EdgeInsets.all(17),
                            17,
                          ),
                          hintText: '712345678',
                          hintStyle: const TextStyle(fontSize: 14),
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
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        onSaved: (PhoneNumber number) {
                          // print('On saved: $number');
                        },
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
                            return "Enter your PIN Number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: passwordvisible,
                        controller: confirmPinNumberController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onSaved: (String? newValue) {
                          pin = newValue;
                        },
                        decoration: InputDecoration(
                          hintText: "Confirm Pin",
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
                        // autovalidateMode: AutovalidateMode.always,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Confirm your PIN Number";
                          } else if (val != pinNumberController.text) {
                            return 'PINs do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("By signing up you agree to our"),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  LoginScreen.routeName,
                                );
                              },
                              child: const Text(
                                "terms and privacy policy",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: CustomButton(
                          text: "Register",
                          color: GlobalVariables.primaryColor,
                          onTap: () {
                            if ((phoneNumber != null || phoneNumber != '') &&
                                _signUpFormKey.currentState!.validate()) {
                              if (pinNumberController.text ==
                                  confirmPinNumberController.text) {
                                final user = UserModel(
                                  id: '',
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  idNumber: idNumberController.text,
                                  phoneNumber: phoneNumber!,
                                  pin: pinNumberController.text,
                                  latitude: 0.0,
                                  longitude: 0.0,
                                  userType: '',
                                  county: '',
                                  subCounty: '',
                                  village: '',
                                  landSize: '',
                                  tractorRegNo: '',
                                  tractorOwnerName: '',
                                  tractorOwnerId: '',
                                  status: '',
                                  isApproved: false,
                                  isOnline: false,
                                  accountBalance: 0,
                                  deviceToken: '',
                                  token: '',
                                  cart: [],
                                );
                                // print(user.phoneNumber);
                                Navigator.of(context).pushNamed(
                                  PhoneVerificationScreen.routeName,
                                  arguments: user,
                                );
                              } else {
                                // show pins do not match error
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            LoginScreen.routeName,
                          );
                        },
                        child: const Text(
                          "Login",
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
