import 'package:agrofi/constants/global_variables.dart';
import 'package:agrofi/farmer/settings/services/account_services.dart';
import 'package:agrofi/models/transaction.dart';
import 'package:agrofi/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  String time = DateTime.now().hour.toString();

  var currentTime = DateFormat.Hms().format(DateTime.now());

  // DateTime now = DateTime.now();
  var date = DateFormat.yMMMEd('en_US').format(DateTime.now());

  final AccountServices _accountServices = AccountServices();

  List<Transaction>? transactions;

  @override
  void initState() {
    super.initState();
    fetchMyTransactions();
  }

  void fetchMyTransactions() async {
    transactions = await _accountServices.fetchRecentTransactions(
      context: context,
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;
    return transactions == null
        ? const Center(
            child: CircularProgressIndicator(
              color: GlobalVariables.primaryColor,
            ),
          )
        : transactions!.isEmpty
            ? Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: GlobalVariables.greyBackGround,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'You have no recent transactions',
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: transactions!.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final transaction = transactions![index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          transaction.transactionType == 'Tractor Payment'
                              ? Icons.agriculture
                              : Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${transaction.amount}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            DateFormat.Hms().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                transaction.date,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          )
                        ],
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // check if user is partyA or B
                          Text(
                            transaction.transactionType,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            DateFormat.yMMMMd().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                transaction.date,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
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
