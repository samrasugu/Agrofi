import 'package:agrofi/farmer/shop/screens/order_details_screen.dart';
import 'package:agrofi/farmer/shop/services/shop_services.dart';
import 'package:agrofi/farmer/shop/widgets/single_product_card.dart';
import 'package:agrofi/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class OrderListTile extends StatefulWidget {
  const OrderListTile({super.key});

  @override
  State<OrderListTile> createState() => _OrderListTileState();
}

class _OrderListTileState extends State<OrderListTile> {
  var currentTime = DateFormat.Hms().format(DateTime.now());

  // DateTime now = DateTime.now();
  var date = DateFormat.yMMMEd('en_US').format(DateTime.now());

  List<Order>? orders;

  final ShopHomeServices shopHomeServices = ShopHomeServices();

  @override
  void initState() {
    super.initState();
    fetchMyOrders();
  }

  void fetchMyOrders() async {
    orders = await shopHomeServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(child: CircularProgressIndicator())
        : orders!.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Column(
                  children: [
                    Center(
                      child: Lottie.asset('assets/icons/no-orders.json'),
                    ),
                    const Text(
                      "Looks like you don't have any orders yet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Your orders will appear here',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: orders!.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        OrderDetailsScreen.routeName,
                        arguments: orders![index],
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      // width: MediaQuery.of(context).size.width * 0.4,
                      // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SingleProductCard(
                            image: orders![index].products[0].productImages[0],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Kenya Agrovets',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${DateFormat.yMMMEd('en_US').format(DateTime.fromMillisecondsSinceEpoch(orders![index].orderedAt))} • ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(orders![index].orderedAt))}',
                              ),
                              Row(
                                children: [
                                  Text(
                                    'KES ${orders![index].totalAmount} • ${orders![index].totalItems} item(s)',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey.shade500,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
  }
}
