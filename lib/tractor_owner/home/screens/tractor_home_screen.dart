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

class TractorOwnerHomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const TractorOwnerHomeScreen({super.key});

  @override
  State<TractorOwnerHomeScreen> createState() => _TractorOwnerHomeScreenState();
}

class _TractorOwnerHomeScreenState extends State<TractorOwnerHomeScreen> {
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
    final user = Provider.of<UserProvider>(context, listen: true).user;
    return Scaffold(
      backgroundColor: GlobalVariables.backGrooundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          elevation: 0,
          backgroundColor: GlobalVariables.greyBackGround,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${greeting()}, ${user.lastName}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
                  size: 28,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 2,
          ),
          child: Column(
            children: [
              const TotalEarnings(),

              const SizedBox(
                height: 10,
              ),

              // status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Status: ",
                      style: const TextStyle(fontSize: 20),
                      children: [
                        TextSpan(
                          text: user.isOnline == false
                              ? "Offline\n"
                              : "Online\n",
                          style: TextStyle(
                            fontSize: 17,
                            color: user.isOnline == false
                                ? Colors.red
                                : GlobalVariables.primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: user.isOnline == false
                              ? "(Tap to go online)"
                              : "(Tap to go offline)",
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoSwitch(
                    value: user.isOnline,
                    onChanged: (value) {
                      setState(
                        () {
                          user.isOnline = value;
                          homeService.changeStatus(
                            context: context,
                            status: value,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              // current active booking
              Row(
                children: const [
                  Text(
                    "Active bookings:",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const ActiveBookingTile(),

              const SizedBox(
                height: 15,
              ),

              // current booking requests
              Row(
                children: const [
                  Text(
                    "Requests:",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              const BookingRequestsListView()
            ],
          ),
        ),
      ),
    );
  }
}
