import 'dart:convert';

class Loan {
  final String id;
  final String userID;
  final String voucherId;
  final String activationData;
  final int requestDate;
  final int issueDate;
  final int dueDate;
  final double principal;
  final double balance;
  final double amount;
  final bool isCurrent;
  final String status;

  Loan({
    required this.id,
    required this.userID,
    required this.voucherId,
    required this.activationData,
    required this.requestDate,
    required this.issueDate,
    required this.dueDate,
    required this.principal,
    required this.balance,
    required this.amount,
    required this.isCurrent,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userID': userID,
      'voucherId': voucherId,
      'activationData': activationData,
      'requestDate': requestDate,
      'issueDate': issueDate,
      'dueDate': dueDate,
      'principal': principal,
      'balance': balance,
      'amount': amount,
      'isCurrent': isCurrent,
      'status': status,
    };
  }

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      id: map['_id'] ?? '',
      userID: map['userID'] ?? '',
      voucherId: map['voucherId'] ?? '',
      activationData: map['activationData'] ?? '',
      requestDate: map['requestDate'] ?? 0,
      issueDate: map['issueDate'] ?? 0,
      dueDate: map['dueDate'] ?? 0,
      principal: (map['principal'] ?? 0).toDouble(),
      balance: (map['balance'] ?? 0).toDouble(),
      amount: (map['amount'] ?? 0).toDouble(),
      isCurrent: map['isCurrent'] ?? false,
      status: map['status'] ?? '',
    );
  }

  String toJson () => json.encode(toMap());

  factory Loan.fromJson(String source) => Loan.fromMap(json.decode(source));

  Loan copyWith({
    String? id,
    String? userID,
    String? voucherId,
    String? activationData,
    int? requestDate,
    int? issueDate,
    int? dueDate,
    double? principal,
    double? balance,
    double? amount,
    bool? isCurrent,
    String? status,
  }) {
    return Loan(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      voucherId: voucherId ?? this.voucherId,
      activationData: activationData ?? this.activationData,
      requestDate: requestDate ?? this.requestDate,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      principal: principal ?? this.principal,
      balance: balance ?? this.balance,
      amount: amount ?? this.amount,
      isCurrent: isCurrent ?? this.isCurrent,
      status: status ?? this.status,
    );
  }
}