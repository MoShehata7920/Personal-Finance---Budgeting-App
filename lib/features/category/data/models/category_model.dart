import 'package:flutter/material.dart';
import 'package:budget_master/core/resources/icons_manager.dart';

class CategoryBudget {
  final String name;
  final double totalAmount;
  final double spentAmount;
  final int iconIndex;

  CategoryBudget({
    required this.name,
    required this.totalAmount,
    required this.spentAmount,
    required this.iconIndex,
  });

  IconData get icon => AppIcons.categoriesIcons[iconIndex];

  CategoryBudget copyWith({
    String? name,
    int? iconIndex,
    double? totalAmount,
    double? spentAmount,
  }) {
    return CategoryBudget(
      name: name ?? this.name,
      iconIndex: iconIndex ?? this.iconIndex,
      totalAmount: totalAmount ?? this.totalAmount,
      spentAmount: spentAmount ?? this.spentAmount,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'totalAmount': totalAmount,
        'spentAmount': spentAmount,
        'iconIndex': iconIndex,
      };

  factory CategoryBudget.fromJson(Map<String, dynamic> json) {
    final dynamic idx = json['iconIndex'];
    final dynamic code = json['iconCode'];

    int resolvedIndex;
    if (idx is int) {
      resolvedIndex = idx.clamp(0, AppIcons.categoriesIcons.length - 1);
    } else if (code is int) {
      resolvedIndex = AppIcons.categoriesIcons.indexWhere(
          (iconData) => iconData.codePoint == code);
      if (resolvedIndex == -1) {
        resolvedIndex = 0;
      }
    } else {
      resolvedIndex = 0;
    }

    return CategoryBudget(
      name: json['name'],
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      spentAmount: (json['spentAmount'] as num?)?.toDouble() ?? 0.0,
      iconIndex: resolvedIndex,
    );
  }
}
