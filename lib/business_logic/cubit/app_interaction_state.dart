part of 'app_interaction_cubit.dart';

class AppInteractionState extends Equatable {
  const AppInteractionState(
      {this.showInformationPanel = false,
      this.isTypeButton = true,
      this.isIncomeFilterSelected = true,
      this.isExpenseFilterSelected = false,
      this.pageFilterChanged = 0,
      this.isPageScroll = true,
      this.isFabMenuOpen = false,
      this.isPageClosed = false});

  final bool showInformationPanel;
  final bool isTypeButton;
  final bool isIncomeFilterSelected;
  final bool isExpenseFilterSelected;
  final int pageFilterChanged;
  final bool isPageScroll;
  final bool isFabMenuOpen;
  final bool isPageClosed;

  AppInteractionState copyWith(
      {bool? showInformationPanel,
      bool? isTypeButton,
      bool? isIncomeFilterSelected,
      bool? isExpenseFilterSelected,
      int? pageFilterChanged,
      bool? isPageScroll,
      bool? isFabMenuOpen,
      bool? isPageClosed}) {
    return AppInteractionState(
        showInformationPanel: showInformationPanel ?? this.showInformationPanel,
        isTypeButton: isTypeButton ?? this.isTypeButton,
        isIncomeFilterSelected:
            isIncomeFilterSelected ?? this.isIncomeFilterSelected,
        isExpenseFilterSelected:
            isExpenseFilterSelected ?? this.isExpenseFilterSelected,
        pageFilterChanged: pageFilterChanged ?? this.pageFilterChanged,
        isPageScroll: isPageScroll ?? this.isPageScroll,
        isFabMenuOpen: isFabMenuOpen ?? this.isFabMenuOpen,
        isPageClosed: isPageClosed ?? this.isPageClosed);
  }

  @override
  List<Object> get props => [
        showInformationPanel,
        isTypeButton,
        isExpenseFilterSelected,
        isIncomeFilterSelected,
        pageFilterChanged,
        isPageScroll,
        isFabMenuOpen,
        isPageClosed
      ];
}
