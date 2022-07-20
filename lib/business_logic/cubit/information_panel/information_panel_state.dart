part of 'information_panel_cubit.dart';

abstract class InformationPanelState extends Equatable {
  const InformationPanelState();

  @override
  List<Object> get props => [];
}

class InformationPanelInitial extends InformationPanelState {
  const InformationPanelInitial();
}

class InformationPanelLoading extends InformationPanelState {
  const InformationPanelLoading();
}

class InformationPanelSuccess extends InformationPanelState {
  final double totalIncome;
  final double currentIncome;
  final double totalExpense;
  final double totalExpenseEssential;
  final double totalExpenseNonEssential;
  final double totalExpenseFixed;
  final double totalExpenseNonFixed;
  final double percentExpenseEssential;
  final double percentExpenseNonEssential;
  final double percentExpenseFixed;
  final double percentExpenseNonFixed;

  const InformationPanelSuccess({
    this.totalExpense = 0.0,
    this.currentIncome = 0.0,
    this.totalExpenseEssential = 0.0,
    this.totalExpenseNonEssential = 0.0,
    this.totalExpenseFixed = 0.0,
    this.totalExpenseNonFixed = 0.0,
    this.totalIncome = 0.0,
    this.percentExpenseEssential = 0.0,
    this.percentExpenseNonEssential = 0.0,
    this.percentExpenseFixed = 0.0,
    this.percentExpenseNonFixed = 0.0,
  });

  InformationPanelSuccess copyWith({
    double? totalIncome,
    double? currentIncome,
    double? totalExpense,
    double? totalExpenseEssential,
    double? totalExpenseNonEssential,
    double? totalExpenseFixed,
    double? totalExpenseNonFixed,
    double? percentExpenseEssential,
    double? percentExpenseNonEssential,
    double? percentExpenseFixed,
    double? percentExpenseNonFixed,
  }) {
    return InformationPanelSuccess(
        totalExpense: totalExpense ?? this.totalExpense,
        currentIncome: currentIncome ?? this.currentIncome,
        totalExpenseEssential:
            totalExpenseEssential ?? this.totalExpenseEssential,
        totalExpenseNonEssential:
            totalExpenseNonEssential ?? this.totalExpenseNonEssential,
        totalExpenseFixed: totalExpenseFixed ?? this.totalExpenseFixed,
        totalExpenseNonFixed: totalExpenseNonFixed ?? this.totalExpenseNonFixed,
        totalIncome: totalIncome ?? this.totalIncome,
        percentExpenseEssential:
            percentExpenseEssential ?? this.percentExpenseEssential,
        percentExpenseNonEssential:
            percentExpenseNonEssential ?? this.percentExpenseNonEssential,
        percentExpenseFixed: percentExpenseFixed ?? this.percentExpenseFixed,
        percentExpenseNonFixed:
            percentExpenseNonFixed ?? this.percentExpenseNonFixed);
  }

  @override
  List<Object> get props => [
        totalExpense,
        currentIncome,
        totalExpenseEssential,
        totalExpenseNonEssential,
        totalExpenseFixed,
        totalExpenseNonFixed,
        totalIncome,
        percentExpenseEssential,
        percentExpenseNonEssential,
        percentExpenseFixed,
        percentExpenseNonFixed
      ];
}
