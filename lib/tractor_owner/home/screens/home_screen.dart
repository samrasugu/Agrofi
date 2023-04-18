import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/tractor_owner/home/services/home_services.dart';
import 'package:agrofi/tractor_owner/home/widgets/active_booking.dart';
import 'package:agrofi/tractor_owner/home/widgets/booking_requests_list_view.dart';
import 'package:agrofi/tractor_owner/home/widgets/total_earnings.dart';
import 'package:agrofi/tractor_owner/notifications/screens/notifications_screen.dart';
import 'package:agrofi/tractor_owner/settings/screens/settings_screen.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good morning";
    }
    if (hour < 17) {
      return "Good afternoon";
    }
    return "Good evening";
  }

  bool isSwitched = false;
  String isOnline = 'Offline';

  final HomeService homeService = HomeService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: GlobalVariables.backGrooundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: GlobalVariables.greyBackGround,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    SettingsScreen.routeName,
                    arguments: {},
                  );
                },
                child: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Agrofi",
                style: TextStyle(
                  fontSize: 30,
                  color: GlobalVariables.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NotificationsScreen.routeName,
                    arguments: {},
                  );
                },
                child: const Icon(
                  Icons.notifications_rounded,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${greeting()} ${user.lastName}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              const TotalEarnings(),

              const SizedBox(
                height: 20,
              ),

              // status
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Status:",
                          style: TextStyle(fontSize: 20),
                        ),
                        // Text(
                        //   user.isOnline == false ? "Offline" : "Online",
                        //   style: TextStyle(
                        //     fontSize: 17,
                        //     color: user.isOnline == false
                        //         ? Colors.red
                        //         : GlobalVariables.primaryColor,
                        //   ),
                        // ),
                      ],
                    ),
                    // CupertinoSwitch(
                    //   value: user.isOnline,
                    //   onChanged: (value) {
                    //     setState(
                    //       () {
                    //         user.isOnline = value;
                    //         homeService.changeStatus(
                    //           context: context,
                    //           status: value,
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),

              // current active booking
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                child: Row(
                  children: const [
                    Text(
                      "Your active booking(s):",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              const ActiveBookingTile(),

              // current booking requests
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                child: Row(
                  children: const [
                    Text(
                      "Requests:",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              const BookingRequestsListView()
            ],
          ),
        ),
      ),
    );
  }
}
