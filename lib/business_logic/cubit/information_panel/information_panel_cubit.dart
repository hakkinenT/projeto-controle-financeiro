import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_controle_financeiro/data/form_models/classification/classification_input.dart';
import 'package:projeto_controle_financeiro/data/models/classification/classification.dart';
import 'package:projeto_controle_financeiro/data/models/expense/expense.dart';
import 'package:projeto_controle_financeiro/data/models/income/income.dart';
import 'package:projeto_controle_financeiro/data/models/models.dart';
import 'package:projeto_controle_financeiro/data/repositories/repositories.dart';
import 'package:projeto_controle_financeiro/utils/app_calc.dart';

import '../../../dependency_injection/setup_locator.dart';

part 'information_panel_state.dart';

class InformationPanelCubit extends Cubit<InformationPanelState> {
  InformationPanelCubit() : super(const InformationPanelInitial());

  final _incomeRepository = getIt<IIncomeRepository>();
  final _expenseRepository = getIt<IExpenseRepository>();

  Future<List<Income>> _getAllIncomes() async {
    return await _incomeRepository.getAllIncomes();
  }

  Future<List<Expense>> _getAllExpense() async {
    return await _expenseRepository.getAllExpense();
  }

  double _sumOfExpenses(List<Expense> expenses) {
    double resultOfSum = expenses.fold(
        0, (previousValue, expense) => previousValue + expense.value);
    return resultOfSum;
  }

  Future<List<Expense>> _getExpenseByType(Type type) async {
    final expenses = await _getAllExpense();

    final listOfExpenseByType =
        expenses.where((expense) => expense.type == type).toList();

    return listOfExpenseByType;
  }

  Future<List<Expense>> _getExpenseByClassification(
      Classification classification) async {
    final expenses = await _getAllExpense();

    final listOfExpenseByClassification = expenses
        .where((expense) => expense.classification == classification)
        .toList();

    return listOfExpenseByClassification;
  }

  Future<double> _totalIncome() async {
    final incomes = await _getAllIncomes();

    double totalIncomes = incomes.fold(
        0, (previousValue, income) => previousValue + income.value);

    return totalIncomes;
  }

  Future<double> _totalExpense() async {
    final expenses = await _getAllExpense();

    double totalExpenses = _sumOfExpenses(expenses);

    return totalExpenses;
  }

  Future<double> _currentIncome() async {
    final totalIncome = await _totalIncome();
    final totalExpense = await _totalExpense();

    final currentIncome = totalIncome - totalExpense;
    return currentIncome;
  }

  Future<double> _totalExpenseEssential() async {
    final expensesEssential =
        await _getExpenseByClassification(Classification.essential);

    double totalExpenseEssential = _sumOfExpenses(expensesEssential);

    return totalExpenseEssential;
  }

  Future<double> _totalExpenseNonEssential() async {
    final expensesNonEssential =
        await _getExpenseByClassification(Classification.nonEssential);

    double totalExpenseNonEssential = _sumOfExpenses(expensesNonEssential);

    return totalExpenseNonEssential;
  }

  Future<double> _totalExpenseFixed() async {
    final expensesFixed = await _getExpenseByType(Type.fixed);

    double totalExpenseFixed = _sumOfExpenses(expensesFixed);

    return totalExpenseFixed;
  }

  Future<double> _totalExpenseNonFixed() async {
    final expensesNonFixed = await _getExpenseByType(Type.nonFixed);

    double totalExpenseNonFixed = _sumOfExpenses(expensesNonFixed);
    return totalExpenseNonFixed;
  }

  Future<double> _percentExpenseEssential() async {
    final totalExpense = await _totalExpense();
    final totalExpenseEssential = await _totalExpenseEssential();

    final percent = AppCalc.percentOfANumber(
        portion: totalExpenseEssential, total: totalExpense);

    return percent;
  }

  Future<double> _percentExpenseNonEssential() async {
    final totalExpense = await _totalExpense();
    final totalExpenseNonEssential = await _totalExpenseNonEssential();

    final percent = AppCalc.percentOfANumber(
        portion: totalExpenseNonEssential, total: totalExpense);
    return percent;
  }

  Future<double> _percentExpenseFixed() async {
    final totalExpense = await _totalExpense();
    final totalExpenseFixed = await _totalExpenseFixed();

    final percent = AppCalc.percentOfANumber(
        portion: totalExpenseFixed, total: totalExpense);

    return percent;
  }

  Future<double> _percentExpenseNonFixed() async {
    final totalExpense = await _totalExpense();
    final totalExpenseNonFixed = await _totalExpenseNonFixed();

    final percent = AppCalc.percentOfANumber(
        portion: totalExpenseNonFixed, total: totalExpense);

    return percent;
  }

  void informationPanelCalculated() async {
    emit(const InformationPanelLoading());

    final totalIncome = await _totalIncome();
    final currentIncome = await _currentIncome();
    final totalExpense = await _totalExpense();
    final totalExpenseEssential = await _totalExpenseEssential();
    final totalExpenseNonEssential = await _totalExpenseNonEssential();
    final totalExpenseFixed = await _totalExpenseFixed();
    final totalExpenseNonFixed = await _totalExpenseNonFixed();
    final percentExpenseEssential = await _percentExpenseEssential();
    final percentExpenseNonEssential = await _percentExpenseNonEssential();
    final percentExpenseFixed = await _percentExpenseFixed();
    final percentExpenseNonFixed = await _percentExpenseNonFixed();

    emit(InformationPanelSuccess(
        totalIncome: totalIncome,
        currentIncome: currentIncome,
        totalExpense: totalExpense,
        totalExpenseEssential: totalExpenseEssential,
        totalExpenseNonEssential: totalExpenseNonEssential,
        totalExpenseFixed: totalExpenseFixed,
        totalExpenseNonFixed: totalExpenseNonFixed,
        percentExpenseEssential: percentExpenseEssential,
        percentExpenseNonEssential: percentExpenseNonEssential,
        percentExpenseFixed: percentExpenseFixed,
        percentExpenseNonFixed: percentExpenseNonFixed));
  }
}
