import 'dart:async';

import 'package:agrofi/auth/screens/user_type_selection_screen.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/animate_loading_screen.dart';
import 'package:agrofi/auth/screens/login_screen.dart';
import 'package:agrofi/auth/services/auth_service.dart';
import 'package:agrofi/farmer/home/screens/farmer_bottom_bar_screen.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:agrofi/router.dart';
import 'package:agrofi/tractor_owner/home/screens/tractor_bottom_bar_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ],
    child: const FirebasePhoneAuthProvider(child: MyApp()),
  ));

  void notificationTapBackground(NotificationResponse notificationResponse) {
    // print(
    //     "notification(${notificationResponse.id}) tapped: ${notificationResponse.actionId} with ${notificationResponse.payload}");
    if (notificationResponse.actionId == "FLUTTER_NOTIFICATION_CLICK") {
      // print("notification tapped");
    }
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // print("notification tapped with input: ${notificationResponse.input}");
    }
  }

  // set up firebase messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  String? navigationActionId = 'FLUTTER_NOTIFICATION_CLICK';
  // Initialize the notification plugin
  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettingsIOS = DarwinInitializationSettings();
  const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
    switch (notificationResponse.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        selectedNotificationStream.add(notificationResponse.payload);
        break;
      case NotificationResponseType.selectedNotificationAction:
        if (notificationResponse.actionId == navigationActionId) {
          selectedNotificationStream.add(notificationResponse.payload);
        }
        break;
    }
  });
}

// handling firebase messaging
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print('Handling a background message ${message.messageId}');
  showNotification(message);
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();
final StreamController<String?> selectedNotificationStream =
    StreamController<String?>.broadcast();

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });

  final int? id;
  final String? title;
  final String? body;
  final String? payload;
}

Future<void> showNotification(RemoteMessage message) async {
  const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id', // id
    'your channel name', // title
    // 'your channel description', // description
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
  const platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification!.title,
    message.notification!.body,
    platformChannelSpecifics,
    payload: message.data.toString(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void configureSelectNotificationSubject(
      BuildContext context, String payload) {
    selectedNotificationStream.stream.listen((String? payload) async {
      await navigatorKey.currentState
          ?.pushNamed('/details', arguments: payload);
    });
  }

  // firebase messaging foreground handler
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        // send pop up notification
        showNotification(message);
      }
    });
  }

  Future<void> _navigateToScreen(String payload) async {
    if (payload.isNotEmpty) {
      if (payload == 'new_message') {}
      // Navigator.pushNamed(context, '/message', arguments: MessageArguments(message, user));
    }
  }

  @override
  void dispose() {
    didReceiveLocalNotificationStream.close();
    selectedNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agrofi',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: GlobalVariables.primaryColor,
        textTheme: Typography.englishLike2021.apply(
          fontSizeFactor: 1,
          bodyColor: Colors.black,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      navigatorKey: navigatorKey,
      home: Builder(builder: (context) {
        return FutureBuilder(
          future: authService.getUserData(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Provider.of<UserProvider>(context).user.token.isNotEmpty
                  ? Provider.of<UserProvider>(context).user.userType == ''
                      ? const Scaffold(
                          body: UserTypeSelectionScreen(),
                        )
                      : Provider.of<UserProvider>(context).user.userType ==
                              "farmer"
                          ? const Scaffold(
                              body: FarmerBottomBarScreen(),
                            )
                          : const Scaffold(
                              body: TractorBottomBarScreen(),
                            )
                  : const LoginScreen();
            }
            return const AnimationLoadingScreen();
          },
        );
      }),
    );
  }
}
