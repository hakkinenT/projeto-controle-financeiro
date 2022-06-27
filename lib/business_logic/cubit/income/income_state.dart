part of 'income_cubit.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();

  @override
  List<Object> get props => [];
}

class IncomeInitial extends IncomeState {}

class IncomeLoading extends IncomeState {}

class IncomeLoaded extends IncomeState {
  final List<Income> incomes;
  const IncomeLoaded({required this.incomes});

  IncomeLoaded copyWith({List<Income>? incomes}) {
    return IncomeLoaded(incomes: incomes ?? this.incomes);
  }

  @override
  List<Object> get props => [incomes];
}

class IncomeSuccess extends IncomeState {}

class IncomeFailure extends IncomeState {
  final String message;

  const IncomeFailure({required this.message});

  IncomeFailure copyWith({String? message}) {
    return IncomeFailure(message: message ?? this.message);
  }

  @override
  List<Object> get props => [message];
}
