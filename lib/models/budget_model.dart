import 'package:personal_finance/models/category_model.dart';

class BudgetModel {
  final double totalBudget;
  final double totalSpent;
  final List<CategoryBudget> categories;

  BudgetModel({
    required this.totalBudget,
    required this.totalSpent,
    required this.categories,
  });

  BudgetModel copyWith({
    double? totalBudget,
    double? totalSpent,
    List<CategoryBudget>? categories,
  }) {
    return BudgetModel(
      totalBudget: totalBudget ?? this.totalBudget,
      totalSpent: totalSpent ?? this.totalSpent,
      categories: categories ?? this.categories,
    );
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      totalBudget: json['totalBudget'],
      totalSpent: json['totalSpent'],
      categories: (json['categories'] as List)
          .map((cat) => CategoryBudget.fromJson(cat))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalBudget': totalBudget,
      'totalSpent': totalSpent,
      'categories': categories.map((cat) => cat.toJson()).toList(),
    };
  }
}
