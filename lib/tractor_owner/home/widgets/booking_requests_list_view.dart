import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/tractor_owner/booking/screens/tractor_booking_details_screen.dart';
import 'package:agrofi/tractor_owner/home/services/home_services.dart';
import 'package:agrofi/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingRequestsListView extends StatefulWidget {
  const BookingRequestsListView({super.key});

  @override
  State<BookingRequestsListView> createState() =>
      _BookingRequestsListViewState();
}

class _BookingRequestsListViewState extends State<BookingRequestsListView> {
  var date = DateFormat.yMMMEd('en_US').format(DateTime.now());
  List<Booking>? bookingList;

  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  void fetchRequests() async {
    bookingList = await homeService.fetchRequests(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return bookingList == null
        ? const Center(
            child: Text("No requests"),
          )
        : ListView.builder(
            itemCount: bookingList!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final booking = bookingList![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TractorOwnerBookingDetailsScreen.routeName,
                    arguments: bookingList![index],
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(10.0),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        10,
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
                            "Farmer's Name:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "${booking.farmer!.firstName} ${booking.farmer!.lastName}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: GlobalVariables.primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${booking.farmer!.village}, ${booking.farmer!.subCounty}, ${booking.farmer!.county} County",
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Date Expected: ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: booking.dateExpected,
                              style: const TextStyle(
                                fontSize: 16,
                                color: GlobalVariables.primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   DateFormat().format(
                      //     DateTime.fromMillisecondsSinceEpoch(
                      //       booking.orderedAt,
                      //     ),
                      //   ),
                      //   style: const TextStyle(
                      //     color: Colors.black54,
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
