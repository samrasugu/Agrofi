import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/booking/screens/booking_details_screen.dart';
import 'package:agrofi/farmer/home/services/home_service.dart';
import 'package:agrofi/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActiveBookingTile extends StatefulWidget {
  const ActiveBookingTile({super.key});

  @override
  State<ActiveBookingTile> createState() => _ActiveBookingTileState();
}

class _ActiveBookingTileState extends State<ActiveBookingTile> {
  var currentTime = DateFormat.Hms().format(DateTime.now());

  List<Booking>? bookingList;

  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  void fetchBookings() async {
    bookingList = await homeService.fetchActiveBookings(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  // DateTime now = DateTime.now();
  var date = DateFormat.yMMMEd('en_US').format(DateTime.now());
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
                margin: const EdgeInsets.symmetric(
                  vertical: 7.0,
                  horizontal: 7.0,
                ),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: GlobalVariables.greyBackGround,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "No active bookings",
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
                            Radius.circular(7),
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
                                    fontWeight: FontWeight.w500,
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
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Status: ",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: booking.status == 1
                                        ? "Active"
                                        : "Inactive",
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
                },
              );
  }
}


























// import 'package:agrofitractor/constants/global_variables.dart';
// import 'package:agrofitractor/features/booking/screens/booking_details_screen.dart';
// import 'package:agrofitractor/features/home/services/home_services.dart';
// import 'package:agrofitractor/models/booking.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ActiveBookingTile extends StatefulWidget {
//   const ActiveBookingTile({super.key});

//   @override
//   State<ActiveBookingTile> createState() => _ActiveBookingTileState();
// }

// class _ActiveBookingTileState extends State<ActiveBookingTile> {
//   var currentTime = DateFormat.Hms().format(DateTime.now());

//   List<Booking>? bookingList;

//    final HomeService homeService = HomeService();

//   @override
//   void initState() {
//     super.initState();
//     fetchRequests();
//   }

//   void fetchRequests() async {
//     bookingList = await homeService.fetchRequests(context: context);
//     setState(() {
      
//     });
//   }

//   // DateTime now = DateTime.now();
//   var date = DateFormat.yMMMEd('en_US').format(DateTime.now());
//   @override
//   Widget build(BuildContext context) {
//     return bookingList == null ? 
//     const Center(child: Text("No requests"),) 
//     : ListView.builder(
//       itemCount: bookingList!.length,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         final booking = bookingList![index];
//         // final booking = bookingList!.where((element) => element.status != 0);
//         if (booking.status != 0) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, BookingDetailsScreen.routeName, arguments: bookingList![index]);
//           },
//           child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             padding: const EdgeInsets.all(10.0),
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: const BorderRadius.all(Radius.circular(15)),
//               border: Border.all(color: Colors.black26, width: 1),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children:  [
//                     const Text("Farmer's Name:",
//                     style: TextStyle(fontSize: 16,
//                     fontWeight: FontWeight.w600),),
//                     const SizedBox(width: 7,),
//                     Text("${booking.farmer.firstName} ${booking.farmer.lastName}",
//                     style:  const TextStyle(fontSize: 16,
//                     color: GlobalVariables.primaryColor,
//                     fontWeight: FontWeight.w400),
//                     ),
//                   ],
//                 ),
//                 Text("${booking.farmer.village}, ${booking.farmer.subCounty}, ${booking.farmer.county} County"),
//                 Text(booking.dateExpected,
//                 style: const TextStyle(
//                   color: Colors.black54
//                 ),)
//                 // Text('${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(booking.orderedAt))}',
//                 // style: const TextStyle(
//                 //   color: Colors.black54
//                 // ),)
//               ],
//             ),
//           ),
//               ),
//         );
//         }
//         return null;
//       },
//     );
//   }
// }