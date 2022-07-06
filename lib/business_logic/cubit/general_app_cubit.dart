import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'general_app_state.dart';

class GeneralAppCubit extends Cubit<GeneralAppState> {
  GeneralAppCubit()
      : super(
            const GeneralAppState(isEditingForm: false, isDeletingForm: false));

  void editingForm({required bool isEditing}) =>
      emit(state.copyWith(isEditingForm: isEditing));

  void deletingForm({required bool isDeleting}) =>
      emit(state.copyWith(isDeletingForm: isDeleting));
}
