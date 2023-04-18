import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/tractor_owner/booking/services/booking_service.dart';
import 'package:agrofi/models/booking.dart';
import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatefulWidget {
  static const String routeName = "/booking-details";
  final Booking booking;
  const BookingDetailsScreen({super.key, required this.booking});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  int currentStep = 0;

  final BookingService bookingService = BookingService();

  @override
  void initState() {
    super.initState();
    currentStep = widget.booking.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Booking details",
          style: TextStyle(fontSize: 18),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text("Order details",
              // style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Farmer's name:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        // Text(
                        //   '${widget.booking.farmer.firstName} ${widget.booking.farmer.lastName}',
                        //   style: const TextStyle(
                        //     fontSize: 15,
                        //     color: GlobalVariables.primaryColor,
                        //   ),
                        // ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "County:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        // Text(
                        //   widget.booking.farmer.county,
                        //   style: const TextStyle(
                        //     fontSize: 15,
                        //     color: GlobalVariables.primaryColor,
                        //   ),
                        // ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Subcounty:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        // Text(
                        //   widget.booking.farmer.subCounty,
                        //   style: const TextStyle(
                        //     fontSize: 15,
                        //     color: GlobalVariables.primaryColor,
                        //   ),
                        // ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Village:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        // Text(
                        //   widget.booking.farmer.village,
                        //   style: const TextStyle(
                        //     fontSize: 15,
                        //     color: GlobalVariables.primaryColor,
                        //   ),
                        // ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Date expected:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.booking.dateExpected,
                          style: const TextStyle(
                            fontSize: 15,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     const Text("Ordered At:",
                    //     style: TextStyle(fontSize: 16),),
                    //     const SizedBox(width: 5,),
                    //     Text(DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.booking.orderedAt)),
                    //     style: const TextStyle(fontSize: 15,
                    //     color: GlobalVariables.primaryColor),),
                    //   ],
                    // ),
                    Row(
                      children: [
                        const Text(
                          "Land Size:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        // Text(
                        //   widget.booking.farmer.landSize,
                        //   style: const TextStyle(
                        //     fontSize: 15,
                        //     color: GlobalVariables.primaryColor,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              // button for accepting request --
              widget.booking.status == 0
                  ? CustomButton(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Confirm'),
                            content: Text(
                                'Do you wish to confirm the tractor request for: ${widget.booking.dateExpected}'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  bookingService.confirmBooking(
                                    context: context,
                                    booking: widget.booking,
                                  );
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Confirm"),
                              )
                            ],
                          ),
                        );
                      },
                      text: 'Accept Request',
                    )
                  : const SizedBox(
                      height: 1,
                    ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Stepper for booking progress
              Stepper(
                currentStep: currentStep,
                physics: const NeverScrollableScrollPhysics(),
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                steps: const [
                  Step(
                    title: Text(
                      "Pending",
                      style: TextStyle(
                        color: GlobalVariables.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'The order is yet to be allocated a tractor',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Step(
                    title: Text(
                      'Active',
                      style: TextStyle(
                        color: GlobalVariables.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'The order has been allocated a tractor and is in progress.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Step(
                    title: Text(
                      'Completed',
                      style: TextStyle(
                        color: GlobalVariables.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'The order has been executed',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
