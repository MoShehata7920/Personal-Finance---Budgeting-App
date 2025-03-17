import 'package:equatable/equatable.dart';
import 'package:personal_finance/models/budget_model.dart';

abstract class BudgetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetLoaded extends BudgetState {
  final BudgetModel budget;

  BudgetLoaded(this.budget);

  @override
  List<Object?> get props => [budget];
}

class BudgetError extends BudgetState {
  final String message;

  BudgetError(this.message);

  @override
  List<Object?> get props => [message];
}
