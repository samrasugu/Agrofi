import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/common/widgets/snack_bar.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/tractor_bookings/services/tractor_booking_services.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookTractorScreen extends StatefulWidget {
  static const String routeName = "/book-tractorscreen";
  const BookTractorScreen({super.key});

  @override
  State<BookTractorScreen> createState() => _BookTractorScreenState();
}

class _BookTractorScreenState extends State<BookTractorScreen> {
  DateTime currentDate = DateTime.now();
  // DateTime selectedDate = DateTime.now();

  String selectedDate = "";

  final TractorBookingServices tractorBookingServices =
      TractorBookingServices();

  void bookTractor() {
    tractorBookingServices.bookTractor(
        context: context, dateExpected: selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book tractor",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: GlobalVariables.primaryColor,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "When would you like a tractor?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: CalendarDatePicker(
                initialDate: currentDate,
                firstDate: DateTime(2023),
                lastDate: DateTime(2024),
                onDateChanged: (picked) {
                  setState(
                    () {
                      selectedDate =
                          '${picked.day}/${picked.month}/${picked.year}';
                    },
                  );
                },
              ),
            ),
            // const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(
                text: 'Book Now',
                color: GlobalVariables.primaryColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Confirm Booking'),
                      content: Text(
                        'Do you wish to book for a tractor on: $selectedDate',
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
                            // Call function to book -- store to db
                            if (selectedDate == "") {
                              Navigator.of(ctx).pop();
                              showSnackBar(context, "Please select a date");
                            } else {
                              bookTractor();
                              Navigator.of(ctx).pop();
                            }
                          },
                          child: const Text(
                            "Confirm",
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
