import 'dart:convert';

class Transaction {
  final String id;
  final String partyA;
  final String partyB;
  final double amount;
  final String transactionType;
  final String transactionID;
  final int status;
  final int date;

  Transaction({
    required this.id,
    required this.partyA,
    required this.partyB,
    required this.amount,
    required this.transactionType,
    required this.transactionID,
    required this.status,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'partyA': partyA,
      'partyB': partyB,
      'amount': amount,
      'transactionType': transactionType,
      'transactionID': transactionID,
      'status': status,
      'date': date,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['_id'] ?? '',
      partyA: map['partyA'] ?? '',
      partyB: map['partyB'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      transactionType: map['transactionType'] ?? '',
      transactionID: map['transactionID'] ?? '',
      status: map['status'] ?? 0,
      date: map['date'] ?? 0,
    );
  }

  String toJson () => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source));

  Transaction copyWith({
    String? id,
    String? partyA,
    String? partyB,
    double? amount,
    String? transactionType,
    String? transactionID,
    int? status,
    int? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      partyA: partyA ?? this.partyA,
      partyB: partyB ?? this.partyB,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      transactionID: transactionID ?? this.transactionID,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }
}