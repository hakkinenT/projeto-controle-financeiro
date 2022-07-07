import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_controle_financeiro/dependency_injection/dependency_injection.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repositories.dart';

part 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  IncomeCubit({
    required IIncomeRepository incomeRepository,
  })  : _incomeRepository = incomeRepository,
        super(IncomeInitial());

  final IIncomeRepository _incomeRepository;

  Future<void> saveIncome(Income income) async {
    emit(IncomeLoading());
    try {
      final user = getIt<AuthenticationRepository>();
      final userId = user.currentUser.id;

      if (income.id == null) {
        await _incomeRepository.addIncome(income: income, userId: userId);
      } else {
        await _incomeRepository.updateIncome(income: income);
      }
      emit(IncomeSuccess());
    } on Exception {
      emit(const IncomeFailure(
          message: 'Houve um erro ao tentar cadastrar a Renda'));
    }
  }

  Future<void> getAllIncomes() async {
    emit(IncomeLoading());
    try {
      final incomes = await _incomeRepository.getAllIncomes();
      emit(IncomeLoaded(incomes: incomes));
    } on Exception {
      emit(const IncomeFailure(
          message: 'Houve um erro ao tentar carregar as Rendas'));
    }
  }

  Future<void> deleteIncome(String incomeId) async {
    emit(IncomeLoading());
    try {
      await _incomeRepository.deleteIncome(incomeId: incomeId);
      emit(IncomeSuccess());
    } on Exception {
      emit(const IncomeFailure(
          message: 'Houve um erro ao tentar excluir a Renda'));
    }
  }
}
