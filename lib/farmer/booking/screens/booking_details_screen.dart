import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/tractor_bookings/services/tractor_booking_services.dart';
import 'package:agrofi/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetailsScreen extends StatefulWidget {
  static const String routeName = "/booking-details";
  final Booking booking;
  const BookingDetailsScreen({
    super.key,
    required this.booking,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  int currentStep = 0;

  bool _hasCallSupport = false;

  // final BookingService bookingService = BookingService();

  @override
  void initState() {
    super.initState();
    currentStep = widget.booking.status;
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _makePhoneCall(String? phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  final TractorBookingServices tractorBookingServices =
      TractorBookingServices();
  
  void _payTractor () async {
    try {
      await tractorBookingServices.payForBooking(
        context: context,
        bookingId: widget.booking.id,
        tractorOwnerID: widget.booking.tractorOwner?.id ?? "",
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        title: const Text(
          "Booking details",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.booking.status != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Tractor Owner's Name:",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              widget.booking.tractorOwner?.firstName ?? "Hello",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: GlobalVariables.greyBackGround,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                ),
                                elevation: 10,
                                isDismissible: true,
                                enableDrag: true,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: const BoxDecoration(
                                              color: GlobalVariables
                                                  .greyBackGround,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  70,
                                                ),
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.person_2_rounded,
                                              size: 60,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '${widget.booking.tractorOwner?.firstName} ${widget.booking.tractorOwner?.lastName}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _makePhoneCall(
                                                widget.booking.tractorOwner
                                                    ?.phoneNumber,
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.phone_enabled_rounded,
                                                ),
                                                Text(
                                                  '${widget.booking.tractorOwner?.phoneNumber}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '${widget.booking.tractorOwner?.tractorRegNo}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            '${widget.booking.tractorOwner?.village}, ${widget.booking.tractorOwner?.subCounty}, ${widget.booking.tractorOwner?.county} County',
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.person_2_rounded,
                            ),
                          ),
                        )
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      7.0,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Order Tracking ID:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.booking.trackingID,
                          style: const TextStyle(
                            fontSize: 14,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Ordered At:",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat.yMMMMEEEEd().format(
                            DateTime.fromMillisecondsSinceEpoch(
                              widget.booking.orderedAt,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Date expected:",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.booking.dateExpected,
                          style: const TextStyle(
                            fontSize: 14,
                            color: GlobalVariables.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                        style: TextStyle(fontSize: 16),
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
              ),
              widget.booking.status == 1
                  ? CustomButton(
                      text: "Pay Tractor",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Confirm Payment'),
                            content: const Text(
                              'Do you wish to pay this tractor owner?\nDoing so will confirm that the service has been completed.\nYour loan allocation will be deducted by KES 2700 and credited to the tractor owner.',
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text(
                                  "Cancel",
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  _payTractor();
                                  // tractorBookingServices.payForBooking(context: context, bookingId: widget.booking.id, tractorOwnerID: widget.booking.tractorOwner!.id);
                                },
                                child: const Text(
                                  "Confirm",
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      color: GlobalVariables.primaryColor,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
