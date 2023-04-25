import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/home/widgets/active_booking_tile.dart';
import 'package:agrofi/farmer/home/widgets/custom_large_button.dart';
import 'package:agrofi/farmer/home/widgets/pending_booking.dart';
import 'package:agrofi/farmer/loans/screens/request_loan_screen.dart';
import 'package:agrofi/farmer/tractor_bookings/screens/book_tractor_screen.dart';
import 'package:agrofi/farmer/home/widgets/loan_balance.dart';
import 'package:agrofi/farmer/notifications/screens/notifications_screen.dart';
import 'package:agrofi/farmer/settings/screens/settings_screen.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FarmerHomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const FarmerHomeScreen({super.key});

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    }
    if (hour < 17) {
      return 'Good afternoon';
    }
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: GlobalVariables.greyBackGround,
          automaticallyImplyLeading: false,
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
              // Text(
              //   "Agrofi",
              //   style: GoogleFonts.julee(
              //     fontSize: 30,
              //     color: GlobalVariables.primaryColor,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
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
      backgroundColor: GlobalVariables.backGrooundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${greeting()}, ${user.firstName}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              const Padding(
                padding: EdgeInsets.all(2.0),
                child: LoanBalance(),
              ),

              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          BookTractorScreen.routeName,
                          arguments: {},
                        );
                      },
                      child: const CustomLargeButton(
                        icon: Icons.agriculture_outlined,
                        maintext: "Book Tractor",
                        subtext: 'Conveniently book a tractor',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RequestLoanScreen.routeName,
                          arguments: {},
                        );
                      },
                      child: const CustomLargeButton(
                        icon: Icons.local_atm_outlined,
                        maintext: "Request Loan",
                        subtext: 'Get a quick loan approved in minutes',
                      ),
                    ),
                  ],
                ),
              ),

              // current active booking
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 8,
                ),
                child: Row(
                  children: const [
                    Text(
                      "Active bookings",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const ActiveBookingTile(),

              // current active booking
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                child: Row(
                  children: const [
                    Text(
                      "Pending bookings",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const PendingBookingsListView(),

              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
