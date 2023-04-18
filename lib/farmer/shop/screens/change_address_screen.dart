import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/home/services/address_services.dart';
import 'package:flutter/material.dart';

class ChangeAddressScreen extends StatefulWidget {
  static const String routeName = '/change-address';
  const ChangeAddressScreen({super.key});

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  //  form controllers
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _subCountyController = TextEditingController();
  final TextEditingController _countyController = TextEditingController();

  final AddressServices addressService = AddressServices();

  @override
  void dispose() {
    super.dispose();
    _villageController.dispose();
    _subCountyController.dispose();
    _countyController.dispose();
  }

  void changeAddress() async {
    await addressService.changeAddress(
      context: context,
      village: _villageController.text,
      subCounty: _subCountyController.text,
      county: _countyController.text,
    );
    // if
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Address'),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter your new address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        'Ensure you enter the correct address. All orders will be delivered to this address and tractor bookings will be directed to this address.'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _countyController,
                      decoration: InputDecoration(
                        hintText: 'Enter your county',
                        contentPadding: EdgeInsetsGeometry.lerp(
                          const EdgeInsets.all(17),
                          const EdgeInsets.all(17),
                          17,
                        ),
                        hintStyle: const TextStyle(fontSize: 16),
                        labelText: 'County',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a county';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _subCountyController,
                      decoration: InputDecoration(
                        hintText: 'Enter your sub county',
                        contentPadding: EdgeInsetsGeometry.lerp(
                          const EdgeInsets.all(17),
                          const EdgeInsets.all(17),
                          17,
                        ),
                        hintStyle: const TextStyle(fontSize: 16),
                        labelText: 'Sub County',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a sub county';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _villageController,
                      decoration: InputDecoration(
                        hintText: 'Enter your area of residence',
                        contentPadding: EdgeInsetsGeometry.lerp(
                          const EdgeInsets.all(17),
                          const EdgeInsets.all(17),
                          17,
                        ),
                        hintStyle: const TextStyle(fontSize: 16),
                        labelText: 'Area Name',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a village';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: 'Update Location',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          changeAddress();
                        }
                      },
                      color: GlobalVariables.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
