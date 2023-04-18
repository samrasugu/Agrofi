import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/common/widgets/custom_textfield.dart';
import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterStepperScreen extends StatefulWidget {
  static const String routeName = "/register-stepper";
  const RegisterStepperScreen({super.key});

  @override
  State<RegisterStepperScreen> createState() => _RegisterStepperScreenState();
}

class _RegisterStepperScreenState extends State<RegisterStepperScreen> {
  final _signUpFormKey1 = GlobalKey<FormState>();
  final _signUpFormKey2 = GlobalKey<FormState>();
  final _signUpFormKey3 = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  late String phoneController;
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController pinNumberController = TextEditingController();
  final TextEditingController confirmPinNumberController =
      TextEditingController();
  final TextEditingController countyController = TextEditingController();
  final TextEditingController subCountyController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController tractorRegNoController = TextEditingController();

  final AuthService authService = AuthService();

  String initialCountry = "KE";
  PhoneNumber number = PhoneNumber(isoCode: "KE");

  int _activeCurrentStep = 0;

  String dropDownValue = "1 acre";
  // list of times for dropdown
  var items = ['1 acre', '2 acres', '3 acres'];

  var countDropDownValue = 'Kwale';
  var counties = ['Kwale', 'Kilifi'];

  // location service functions
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    // check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // not enabled --> request user to enable
      if (mounted) {
        showSnackBar(context, "Location disabled please switch it on");
      }
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        if (mounted) {
          showSnackBar(context, "You have denied the app access to location");
        }
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      if (mounted) {
        showSnackBar(
          context,
          "Location permissions denied forever. Cannot request for location",
        );
      }
    }

    // here permissions are granted and we can get location details
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    idNumberController.dispose();
    phoneNumberController.dispose();
    pinNumberController.dispose();
    confirmPinNumberController.dispose();
    countyController.dispose();
    subCountyController.dispose();
    villageController.dispose();
  }

  void signUp() async {
    Position position = await _determinePosition();
    if (mounted) {
      authService.signUpUser(
        context: context,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController,
        pin: pinNumberController.text,
      );
    }
  }

  List<Step> stepList() => [
        // step1
        Step(
          state:
              _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 0,
          title: const Text("Account"),
          content: Form(
            key: _signUpFormKey1,
            child: Column(
              children: [
                CustomTextField(
                    controller: firstNameController, hintText: "First Name"),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: lastNameController, hintText: "Last Name"),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: idNumberController, hintText: "ID Number"),
                const SizedBox(
                  height: 20,
                ),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    // print(number.phoneNumber);
                    setState(() {
                      phoneController = number.phoneNumber.toString();
                    });
                  },
                  onInputValidated: (bool value) {
                    // print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  initialValue: number,
                  // textFieldController: phoneNumberController,
                  formatInput: true,
                  hintText: '712345678',
                  textStyle: const TextStyle(fontSize: 13),
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  inputBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  onSaved: (PhoneNumber number) {
                    // print('On saved: $number');
                    setState(() {
                      phoneController = number.phoneNumber.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),

        // step 2
        Step(
          state:
              _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 1,
          title: const Text("Location"),
          content: Form(
            key: _signUpFormKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomTextField(
                //     controller: countyController, hintText: "County"),
                const Text('Select your county'),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton(
                    value: countDropDownValue,
                    isExpanded: true,
                    items: counties.map((String counties) {
                      return DropdownMenuItem(
                        value: counties,
                        child: Text(counties),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          countDropDownValue = newValue!;
                          // print(dropDownValue);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: subCountyController, hintText: "SubCounty"),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: villageController,
                    hintText: "Village/Area name"),
                const SizedBox(
                  height: 20,
                ),
                const Text('What is your land size?'),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: DropdownButton(
                    value: dropDownValue,
                    isExpanded: true,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          dropDownValue = newValue!;
                          // print(dropDownValue);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),

        // Step 3
        Step(
            state: StepState.complete,
            isActive: _activeCurrentStep >= 2,
            title: const Text("Confirm"),
            content: Form(
              key: _signUpFormKey3,
              child: Column(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(bottom: 10.0, left: 5.0),
                    child: Text(
                      "Please set your PIN. You will use this PIN to log in to your account",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: pinNumberController,
                    decoration: const InputDecoration(
                      hintText: "PIN number",
                      hintStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter your PIN";
                      } else if (val.length != 4) {
                        return "Your PIN must be 4 digits";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // CustomTextField(
                  //     controller: confirmPinNumberController,
                  //     hintText: "Confirm your PIN"),
                  TextFormField(
                    controller: confirmPinNumberController,
                    decoration: const InputDecoration(
                      hintText: "Confirm PIN number",
                      hintStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please confirm your PIN";
                      } else if (val.length != 4) {
                        return "Your PIN must be 4 digits";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    text: 'Register',
                    color: GlobalVariables.primaryColor,
                    onTap: () {
                      if (_signUpFormKey3.currentState!.validate()) {
                        if (pinNumberController.text ==
                            confirmPinNumberController.text) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Location Consent'),
                              content: const Text(
                                  'This app requires your location in order to offer services and function properly.\nTap "Confirm" to accept and continue with sign up.'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("Cancel")),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                    signUp();
                                  },
                                  child: const Text("Confirm"),
                                )
                              ],
                            ),
                          );
                        } else {
                          showSnackBar(context, "Your pins do not match");
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        title: const Text(
          "Register",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _activeCurrentStep,
              elevation: 0,
              steps: stepList(),
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          if (_activeCurrentStep == 0) {
                            if (_signUpFormKey1.currentState!.validate()) {
                              _signUpFormKey1.currentState!.save();
                              setState(() {
                                _activeCurrentStep += 1;
                              });
                            }
                          } else if (_activeCurrentStep == 1) {
                            if (_signUpFormKey2.currentState!.validate()) {
                              _signUpFormKey2.currentState!.save();
                              setState(() {
                                _activeCurrentStep += 1;
                              });
                            }
                          }
                          // if (_signUpFormKey1.currentState!.validate()) {
                          //   if (_activeCurrentStep < (stepList().length - 1)) {
                          //     setState(() {
                          //       _activeCurrentStep += 1;
                          //     });
                          //   }
                          // }
                        },
                        child: const Text("NEXT")),
                    TextButton(
                        onPressed: () {
                          if (_activeCurrentStep == 0) {
                            return;
                          }
                          setState(() {
                            _activeCurrentStep -= 1;
                          });
                        },
                        child: const Text("BACK"))
                  ],
                );
              },

              // // onStepTap allows us to click the step
              // onStepTapped: (int index) {
              //   setState(() {
              //     _activeCurrentStep = index;
              //   });
              // },
            ),
          ),
          // const Text("Hello")
        ],
      ),
    );
  }
}
