import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/booking/screens/booking_details_screen.dart';
import 'package:agrofi/farmer/home/services/home_service.dart';
import 'package:agrofi/models/booking.dart';
import 'package:flutter/material.dart';

class PendingBookingsListView extends StatefulWidget {
  const PendingBookingsListView({super.key});

  @override
  State<PendingBookingsListView> createState() =>
      _PendingBookingsListViewState();
}

class _PendingBookingsListViewState extends State<PendingBookingsListView> {
  List<Booking>? bookingList;

  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  void fetchBookings() async {
    bookingList = await homeService.fetchBookings(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return bookingList == null || bookingList!.isEmpty
        ? Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: const BoxDecoration(
              color: GlobalVariables.greyBackGround,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: const Center(
              child: Text("No pending bookings"),
            ),
          )
        : ListView.builder(
            itemCount: bookingList!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final booking = bookingList![index];
              if (booking.status == 0) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      BookingDetailsScreen.routeName,
                      arguments: bookingList![index],
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 7.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.all(10.0),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            7,
                          ),
                        ),
                        border: Border.all(
                          color: Colors.black26,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Tractor Owner's Name:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                booking.tractorOwner?.firstName ?? "Hello",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: GlobalVariables.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Date expected: ${booking.dateExpected}",
                          ),
                          const Text(
                            "Status",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
  }
}
