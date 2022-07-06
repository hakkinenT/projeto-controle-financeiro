part of 'expense_cubit.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  const ExpenseLoaded({required this.expenses});

  ExpenseLoaded copyWith({List<Expense>? expenses}) {
    return ExpenseLoaded(expenses: expenses ?? this.expenses);
  }

  @override
  List<Object> get props => [expenses];
}

class ExpenseSuccess extends ExpenseState {}

class ExpenseFailure extends ExpenseState {
  final String message;
  const ExpenseFailure({required this.message});

  @override
  List<Object> get props => [message];
}
