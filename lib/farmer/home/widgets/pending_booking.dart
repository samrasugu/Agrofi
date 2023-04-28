import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/booking/screens/booking_details_screen.dart';
import 'package:agrofi/farmer/home/services/home_service.dart';
import 'package:agrofi/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return bookingList == null
        ? const Center(
            child: CircularProgressIndicator(
              color: GlobalVariables.primaryColor,
            ),
          )
        : bookingList!.isEmpty
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
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: const Center(
                  child: Text(
                    "No pending bookings",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
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
                          height: 120,
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
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Ordered on: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: " ",
                                    ),
                                    TextSpan(
                                      text: DateFormat.yMMMMEEEEd().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          booking.orderedAt,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: GlobalVariables.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Expected on: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: " ",
                                    ),
                                    TextSpan(
                                      text: booking.dateExpected,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: GlobalVariables.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Status: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: " ",
                                    ),
                                    TextSpan(
                                      text: booking.status == 0
                                          ? "Pending"
                                          : booking.status == 1
                                              ? "Accepted"
                                              : "Rejected",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: GlobalVariables.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                    // return Container(
                    //   height: MediaQuery.of(context).size.height * 0.1,
                    //   width: MediaQuery.of(context).size.width * 0.85,
                    //   decoration: const BoxDecoration(
                    //     color: GlobalVariables.greyBackGround,
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(
                    //         10,
                    //       ),
                    //     ),
                    //   ),
                    //   margin: const EdgeInsets.symmetric(
                    //     horizontal: 10.0,
                    //   ),
                    //   child: const Center(
                    //     child: Text("No pendig bookings"),
                    //   ),
                    // );
                  }
                },
              );
  }
}
