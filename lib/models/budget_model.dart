import 'package:personal_finance/models/category_model.dart';
import 'package:personal_finance/models/transactions_model.dart';

class BudgetModel {
  final double totalBudget;
  final double totalSpent;
  final List<CategoryBudget> categories;
  final List<TransactionModel> transactions;

  BudgetModel({
    required this.totalBudget,
    required this.totalSpent,
    required this.categories,
    this.transactions = const [],
  });

  BudgetModel copyWith({
    double? totalBudget,
    double? totalSpent,
    List<CategoryBudget>? categories,
    List<TransactionModel>? transactions,
  }) {
    return BudgetModel(
      totalBudget: totalBudget ?? this.totalBudget,
      totalSpent: totalSpent ?? this.totalSpent,
      categories: categories ?? this.categories,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toJson() => {
        'totalBudget': totalBudget,
        'totalSpent': totalSpent,
        'categories': categories.map((c) => c.toJson()).toList(),
        'transactions': transactions.map((t) => t.toJson()).toList(),
      };

  factory BudgetModel.fromJson(Map<String, dynamic> json) => BudgetModel(
        totalBudget: (json['totalBudget'] as num?)?.toDouble() ?? 0.0,
        totalSpent: (json['totalSpent'] as num?)?.toDouble() ?? 0.0,
        categories: (json['categories'] as List?)
                ?.map((c) => CategoryBudget.fromJson(c))
                .toList() ??
            [],
        transactions: (json['transactions'] as List?)
                ?.map((t) => TransactionModel.fromJson(t))
                .toList() ??
            [],
      );
}
