import 'package:flutter/material.dart';

class CategoryBudget {
  final String name;
  final double totalAmount;
  final double spentAmount;
  final int iconCode;

  CategoryBudget({
    required this.name,
    required this.totalAmount,
    required this.spentAmount,
    required this.iconCode,
  });

  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');

  CategoryBudget copyWith({
    String? name,
    int? iconCode,
    double? totalAmount,
    double? spentAmount,
  }) {
    return CategoryBudget(
      name: name ?? this.name,
      iconCode: iconCode ?? this.iconCode,
      totalAmount: totalAmount ?? this.totalAmount,
      spentAmount: spentAmount ?? this.spentAmount,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'totalAmount': totalAmount,
        'spentAmount': spentAmount,
        'iconCode': iconCode,
      };

  factory CategoryBudget.fromJson(Map<String, dynamic> json) => CategoryBudget(
        name: json['name'],
        totalAmount: json['totalAmount'],
        spentAmount: json['spentAmount'],
        iconCode: json['iconCode'],
      );
}
