import 'package:agrofi/auth/services/auth_service.dart';
import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/common/widgets/custom_textfield.dart';
import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StepTwoRegistration extends StatefulWidget {
  static const routeName = "/farmer-step-two-registration";
  final bool isFarmer;
  const StepTwoRegistration({super.key, required this.isFarmer});

  @override
  State<StepTwoRegistration> createState() => _StepTwoRegistrationState();
}

class _StepTwoRegistrationState extends State<StepTwoRegistration> {
  // 2 form keys
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  // farmer input controls
  final TextEditingController landSizecontroller = TextEditingController();

  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController countyController = TextEditingController();
  final TextEditingController subCountyController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  // tractor owner input controls
  final TextEditingController tractorRegNoController = TextEditingController();
  final TextEditingController tractorOwnerNameController =
      TextEditingController();
  final TextEditingController tractorOwnerIDController =
      TextEditingController();

  String landDropDownValue = "1 acre";
  // list of times for dropdown
  var landitems = ['1 acre', '2 acres', '3 acres'];

  String dropDownValue = "Yes";
  // list of times for dropdown
  var items = ['Yes', 'No'];

  var countDropDownValue = 'County';
  var counties = ['County', 'Kwale', 'Kilifi'];

  bool countybool = false;

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

  final AuthService _authService = AuthService();

  final FirebaseMessaging _fireBaseMessaging = FirebaseMessaging.instance;

  // farmer complete profile
  void _registerFarmer() async {
    Position position = await _determinePosition();
    // Get the device token
    String? deviceToken = await _fireBaseMessaging.getToken();
    if (mounted) {
      await _authService.farmerCompleteProfile(
        context: context,
        idNumber: idNumberController.text,
        latitude: position.latitude,
        longitude: position.longitude,
        userType: 'farmer',
        county: countDropDownValue,
        subCounty: subCountyController.text,
        village: villageController.text,
        landSize: landDropDownValue,
        deviceToken: deviceToken!,
      );
    }
  }

  // tractor owner complete profile
  void _registerTactorOwner() async {
    Position position = await _determinePosition();
    // Get the device token
    String? deviceToken = await _fireBaseMessaging.getToken();
    if (mounted) {
      await _authService.tractorCompleteProfile(
        context: context,
        idNumber: idNumberController.text,
        latitude: position.latitude,
        longitude: position.longitude,
        userType: 'tractor_owner',
        county: countDropDownValue,
        subCounty: subCountyController.text,
        village: villageController.text,
        tractorRegNo: tractorRegNoController.text,
        tractorOwnerName: tractorOwnerNameController.text,
        tractorOwnerId: tractorOwnerIDController.text,
        deviceToken: deviceToken!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text(
        //   "Farmer Step Two Registration",
        //   style: TextStyle(fontSize: 15),
        // ),
        backgroundColor: GlobalVariables.primaryColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 22.0),
                child: Text(
                  "Complete your profile",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              widget.isFarmer
                  ? Container(
                      margin: const EdgeInsets.all(
                        20,
                      ),
                      child: Form(
                        key: _formKey1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: idNumberController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                hintText: 'ID Number',
                                contentPadding: EdgeInsetsGeometry.lerp(
                                  const EdgeInsets.all(17),
                                  const EdgeInsets.all(17),
                                  17,
                                ),
                                hintStyle: const TextStyle(fontSize: 16),
                                labelText: 'ID Number',
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black38,
                                  ),
                                  gapPadding: 4.0,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
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
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Enter your ID Number";
                                }
                                return null;
                              },
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 2.0,
                              ),
                              child: Text(
                                'What is the size of your land?',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 1.0,
                              ),
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black38,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              child: DropdownButton(
                                value: landDropDownValue,
                                isExpanded: true,
                                underline: const SizedBox.shrink(),
                                items: landitems.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(
                                    () {
                                      landDropDownValue = newValue!;
                                    },
                                  );
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 2.0, top: 15.0),
                              child: Text(
                                'Select your county of residence',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 1.0,
                              ),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black38,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              child: DropdownButton(
                                value: countDropDownValue,
                                isExpanded: true,
                                underline: const SizedBox.shrink(),
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
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            countybool == true
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 15.0,
                                      left: 2.0,
                                    ),
                                    child: Text(
                                      "Select your county",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            CustomTextField(
                              controller: subCountyController,
                              labelText: 'Sub County',
                              hintText: 'Sub County',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: villageController,
                              labelText: 'Area Name',
                              hintText: 'Area Name',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              text: 'Submit',
                              onTap: () {
                                if (_formKey1.currentState!.validate()) {
                                  if (countDropDownValue == 'County') {
                                    setState(() {
                                      countybool = true;
                                    });
                                  } else {
                                    setState(() {
                                      countybool = false;
                                    });
                                    // send data to server
                                    _registerFarmer();
                                  }
                                }
                              },
                              color: GlobalVariables.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10.0,
                      ),
                      child: Form(
                        key: _formKey2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 2.0, top: 15.0),
                              child: Text(
                                'Select your county of residence',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 1.0,
                              ),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black38,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              child: DropdownButton(
                                value: countDropDownValue,
                                underline: const SizedBox.shrink(),
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
                            countybool == true
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 15.0,
                                      left: 2.0,
                                    ),
                                    child: Text(
                                      "Select your county",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: subCountyController,
                              labelText: 'Sub County',
                              hintText: 'Sub County',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: villageController,
                              labelText: 'Area Name',
                              hintText: 'Area Name',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: tractorRegNoController,
                              hintText: 'Tractor Registration Number',
                              labelText: 'Tractor Registration Number',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: idNumberController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                hintText: 'ID Number',
                                labelText: 'ID Number',
                                contentPadding: EdgeInsetsGeometry.lerp(
                                  const EdgeInsets.all(17),
                                  const EdgeInsets.all(17),
                                  17,
                                ),
                                hintStyle: const TextStyle(fontSize: 16),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black38,
                                  ),
                                  gapPadding: 4.0,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
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
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Enter your ID Number";
                                }
                                return null;
                              },
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 2.0, bottom: 5.0),
                              child: Text(
                                'Are you the owner of the tractor?',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 1.0,
                              ),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black38,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              child: DropdownButton(
                                value: dropDownValue,
                                underline: const SizedBox.shrink(),
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
                            dropDownValue == "No"
                                ? Column(
                                    children: [
                                      CustomTextField(
                                        controller: tractorOwnerNameController,
                                        labelText: 'Tractor Owner\'s Name',
                                        hintText: "Full names of Owner",
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomTextField(
                                        controller: tractorOwnerIDController,
                                        labelText: 'Tractor Owner\'s ID',
                                        hintText: "Enter ID no of owner",
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            CustomButton(
                              text: 'Submit',
                              onTap: () {
                                if (_formKey2.currentState!.validate()) {
                                  if (countDropDownValue == 'County') {
                                    setState(() {
                                      countybool = true;
                                    });
                                  } else {
                                    setState(() {
                                      countybool = false;
                                    });
                                    print("Validated");
                                    // send data to server
                                    _registerTactorOwner();
                                  }
                                }
                              },
                              color: GlobalVariables.primaryColor,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
