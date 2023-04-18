import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/shop/screens/store_details_screen.dart';
import 'package:agrofi/farmer/shop/services/shop_services.dart';
import 'package:agrofi/models/store.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StoresList extends StatefulWidget {
  const StoresList({super.key});

  @override
  State<StoresList> createState() => _StoresListState();
}

class _StoresListState extends State<StoresList> {
  List<Store>? storesList;

  final ShopHomeServices shopHomeServices = ShopHomeServices();

  @override
  void initState() {
    super.initState();
    fetchStores();
  }

  void fetchStores() async {
    storesList = await shopHomeServices.fetchStores(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return storesList == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          )
        : storesList!.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Lottie.asset(
                          'assets/icons/124125-store-icon.json',
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        const Text(
                          'Looks like we can\'t find any stores near you',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'Make sure you have location services enabled and that your location details are correct.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : GridView.builder(
                itemCount: storesList!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final store = storesList![index];
                  // print(storesList!.length);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        StoreDetailsScreen.routeName,
                        arguments: storesList![index],
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10.0,
                      ),
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 1,
                        //     blurRadius: 7,
                        //     offset: const Offset(0, 3),
                        //   ),
                        // ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.only(
                              //   topLeft: Radius.circular(10),
                              //   topRight: Radius.circular(10),
                              // ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://images.pexels.com/photos/4483610/pexels-photo-4483610.jpeg?auto=compress&cs=tinysrgb&w=600',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Text(
                              store.businessName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Padding(
                            padding: EdgeInsets.only(left: 1.0),
                            child: Text.rich(
                              TextSpan(
                                // text: 'KES 1000',
                                // style: TextStyle(
                                //   fontSize: 16,
                                //   fontWeight: FontWeight.bold,
                                //   color: Colors.green,
                                // ),
                                children: [
                                  TextSpan(
                                    text: 'KES 90 Delivery fee •',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black45,
                                      // decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' 20-30 mins',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
  }
}
