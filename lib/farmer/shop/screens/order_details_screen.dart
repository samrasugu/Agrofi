import 'package:agrofi/common/widgets/custom_button.dart';
import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: GlobalVariables.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // order summary
              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GlobalVariables.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Date: ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}',
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 17,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Order ID: ${widget.order.id}",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 17,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Total: KES ${widget.order.totalAmount}",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 17,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
              // purchase details
              const Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GlobalVariables.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                padding: const EdgeInsets.all(
                  10.0,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                              child: Image.network(
                                widget.order.products[i].productImages[0],
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.order.products[i].productName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Quantity: ${widget.order.quantity[i].toString()}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade700,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
              // Stepper for booking progress
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 1.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GlobalVariables.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Stepper(
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
                          'The order is yet to be accepted by the store owner.',
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
                          'The order has been accepted and is in progress.',
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
                          'You received your order.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              widget.order.status == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 1.0,
                        vertical: 8.0,
                      ),
                      child: CustomButton(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Confirm'),
                              content: Text(
                                  'Do you wish to confirm the tractor request for: ${widget.order.status}'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text("Confirm"),
                                )
                              ],
                            ),
                          );
                        },
                        text: 'Confirm Receipt',
                        color: GlobalVariables.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
