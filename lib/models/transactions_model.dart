class TransactionModel {
  final String id;
  final String categoryName;
  final double amount;
  final DateTime date;
  final String? note;

  TransactionModel({
    required this.id,
    required this.categoryName,
    required this.amount,
    required this.date,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryName': categoryName,
        'amount': amount,
        'date': date.toIso8601String(),
        'note': note,
      };

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        categoryName: json['categoryName'],
        amount: json['amount'],
        date: DateTime.parse(json['date']),
        note: json['note'],
      );
}
