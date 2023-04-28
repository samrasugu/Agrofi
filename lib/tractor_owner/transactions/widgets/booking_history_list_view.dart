import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/models/booking.dart';
import 'package:agrofi/tractor_owner/booking/screens/tractor_booking_details_screen.dart';
import 'package:agrofi/tractor_owner/home/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingHistoryListView extends StatefulWidget {
  const BookingHistoryListView({super.key});

  @override
  State<BookingHistoryListView> createState() => _BookingHistoryListViewState();
}

class _BookingHistoryListViewState extends State<BookingHistoryListView> {
  var date = DateFormat.yMMMEd('en_US').format(DateTime.now());

  List<Booking>? bookingList;

  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  void fetchRequests() async {
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 7.0,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(
                      10.0,
                    ),
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
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Farmer's Name: ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${booking.farmer!.firstName} ${booking.farmer!.lastName}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: GlobalVariables.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "County: ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${booking.farmer!.village}, ${booking.farmer!.subCounty}, ${booking.farmer!.county}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: GlobalVariables.primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Date Expected: ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: booking.dateExpected,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: GlobalVariables.primaryColor,
                                  fontWeight: FontWeight.w400,
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
            },
          );
  }
}
