import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/settings/widgets/custom_disabled_text_field.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = "/account-screen";
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
   final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController userType = TextEditingController();
  final TextEditingController countyController = TextEditingController();
  final TextEditingController subCountyController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController tractorRegNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: GlobalVariables.backGrooundColor,
      appBar: AppBar(
        title: const Text("Profile",
        style: TextStyle(fontSize: 16),),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 10,),
          //   Center(
          //   child: Column(
          //     children: [
          //       GestureDetector(
          //         onTap: (){
          //           Navigator.pushNamed(context, AccountScreen.routeName, arguments: {});
          //         },
          //         child: const CircleAvatar(
          //           radius: 60,
          //           backgroundColor: Colors.white,
          //           backgroundImage: AssetImage('assets/icons/usericon.png'
          //           ),
          //         ),
          //       ),
          //       const SizedBox(height: 10,),
          //       const Text("Sam Rasugu",
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w700
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // user data
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomDisabledTextField(controller: firstNameController, hintText: "${user.firstName} ${user.lastName}", maxLines: 1),
                CustomDisabledTextField(controller: phoneNumberController, hintText: user.phoneNumber, maxLines: 1),
                CustomDisabledTextField(controller: idNumberController, hintText: user.idNumber, maxLines: 1),
                CustomDisabledTextField(controller: countyController, hintText: user.county, maxLines: 1),
                CustomDisabledTextField(controller: subCountyController, hintText: user.subCounty, maxLines: 1),
                CustomDisabledTextField(controller: villageController, hintText: user.village, maxLines: 1),
                CustomDisabledTextField(controller: villageController, hintText: user.landSize, maxLines: 1),
      
              ],
            ),
          )
          ],
           ),
      ),
    );
  }
}