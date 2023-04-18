import 'package:agrofi/auth/screens/step_two_registeration.dart';
import 'package:agrofi/auth/screens/login_screen.dart';
import 'package:agrofi/auth/screens/phone_verification_screen.dart';
import 'package:agrofi/auth/screens/register_screen.dart';
import 'package:agrofi/auth/screens/registration_stepper.dart';
import 'package:agrofi/auth/screens/user_type_selection_screen.dart';
import 'package:agrofi/farmer/booking/screens/booking_details_screen.dart';
import 'package:agrofi/farmer/loans/screens/request_loan_screen.dart';
import 'package:agrofi/farmer/shop/screens/change_address_screen.dart';
import 'package:agrofi/farmer/shop/screens/checkout_screen.dart';
import 'package:agrofi/farmer/shop/screens/cart_screen.dart';
import 'package:agrofi/farmer/shop/screens/order_details_screen.dart';
import 'package:agrofi/farmer/shop/screens/product_details_screen.dart';
import 'package:agrofi/farmer/shop/screens/shop_bottombar_screen.dart';
import 'package:agrofi/farmer/shop/screens/shop_home_screen.dart';
import 'package:agrofi/farmer/shop/screens/store_details_screen.dart';
import 'package:agrofi/farmer/tractor_bookings/screens/book_tractor_screen.dart';
import 'package:agrofi/farmer/home/screens/farmer_bottom_bar_screen.dart';
import 'package:agrofi/farmer/home/screens/farmer_home_screen.dart';
import 'package:agrofi/farmer/notifications/screens/notifications_screen.dart';
import 'package:agrofi/farmer/shop/screens/orders_screen.dart';
import 'package:agrofi/farmer/settings/screens/account_screen.dart';
import 'package:agrofi/farmer/settings/screens/settings_screen.dart';
import 'package:agrofi/farmer/loans/screens/loans_main_screen.dart';
import 'package:agrofi/farmer/transactions/screens/transactions_list_screen.dart';
import 'package:agrofi/models/booking.dart';
import 'package:agrofi/models/order.dart';
import 'package:agrofi/models/product.dart';
import 'package:agrofi/models/store.dart';
import 'package:agrofi/models/user.dart';
import 'package:agrofi/tractor_owner/home/screens/tractor_bottom_bar_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case RegisterScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegisterScreen(),
      );
    case PhoneVerificationScreen.routeName:
      final user = routeSettings.arguments as UserModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PhoneVerificationScreen(
          user: user,
        ),
      );
    case UserTypeSelectionScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const UserTypeSelectionScreen(),
      );
    case StepTwoRegistration.routeName:
      var isFarmer = routeSettings.arguments as bool;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => StepTwoRegistration(
          isFarmer: isFarmer,
        ),
      );
    case FarmerBottomBarScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FarmerBottomBarScreen(),
      );
    case FarmerHomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FarmerHomeScreen(),
      );
    case SettingsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SettingsScreen(),
      );
    case AccountScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AccountScreen(),
      );
    case OrdersScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrdersScreen(),
      );
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreen(
          order: order,
        ),
      );
    case NotificationsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotificationsScreen(),
      );
    case LoansMainScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoansMainScreen(),
      );
    case BookTractorScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BookTractorScreen(),
      );
    case RegisterStepperScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegisterStepperScreen(),
      );
    case BookingDetailsScreen.routeName:
      var booking = routeSettings.arguments as Booking;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BookingDetailsScreen(
          booking: booking,
        ),
      );
    case RequestLoanScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RequestLoanScreen(),
      );
    case TransactionsListScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TransactionsListScreen(),
      );
    case ShopBottomBarScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ShopBottomBarScreen(),
      );
    case ShopHomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ShopHomeScreen(),
      );
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(
          product: product,
        ),
      );
    case StoreDetailsScreen.routeName:
      var store = routeSettings.arguments as Store;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => StoreDetailsScreen(
          store: store,
        ),
      );
    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );
    case CheckoutScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CheckoutScreen(),
      );
    case ChangeAddressScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ChangeAddressScreen(),
      );
    case TractorBottomBarScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TractorBottomBarScreen(),
      );
    // case '/':
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const BottomBarScreen());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("The page does not exist"),
          ),
        ),
      );
  }
}
