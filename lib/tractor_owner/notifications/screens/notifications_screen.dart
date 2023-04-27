import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/tractor_owner/notifications/widgets/notifications_list_view.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = "/tractor-notifications-screen";
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [NotificationsListView()],
        ),
      ),
    );
  }
}
