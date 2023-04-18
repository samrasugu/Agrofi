import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TractorBookingsListView extends StatefulWidget {
  const TractorBookingsListView({super.key});

  @override
  State<TractorBookingsListView> createState() => _TractorBookingsListViewState();
}

class _TractorBookingsListViewState extends State<TractorBookingsListView> {
  
  var currentTime = DateFormat.Hms().format(DateTime.now());

  // DateTime now = DateTime.now();
  var date = DateFormat.yMMMEd('en_US').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.person_2_rounded),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("KES 1200",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600
              ),),
              const SizedBox(height: 5,),
              Text(currentTime, 
              style: TextStyle(
                color: Colors.grey.shade700,
              ),)
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Kilimo Tractors",
              style: TextStyle(
                fontWeight: FontWeight.w600
              ),),
              const SizedBox(height: 5,),
              Text(date, style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700
              ),),
            ],
          ),
        );
      },
    );
  }
}