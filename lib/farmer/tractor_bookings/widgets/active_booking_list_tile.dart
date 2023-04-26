import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActiveTractorBooking extends StatefulWidget {
  const ActiveTractorBooking({super.key});

  @override
  State<ActiveTractorBooking> createState() => _ActiveTractorBookingState();
}

class _ActiveTractorBookingState extends State<ActiveTractorBooking> {
  var currentTime = DateFormat.Hms().format(DateTime.now());

  // DateTime now = DateTime.now();
  var date = DateFormat.yMMMEd('en_US').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.person_2_rounded,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "KES 1200",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            currentTime,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Kilimo Tractors",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
