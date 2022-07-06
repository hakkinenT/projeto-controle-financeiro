import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_interaction_state.dart';

class FormInteractionCubit extends Cubit<FormInteractionState> {
  FormInteractionCubit() : super(const FormInteractionInitial());

  void formRegister() => emit(const FormInteractionRegister());

  void formEdit() => emit(const FormInteractionEdit());

  void formDelete() => emit(const FormInteractionDelete());
}
