part of 'form_interaction_cubit.dart';

abstract class FormInteractionState extends Equatable {
  const FormInteractionState();

  @override
  List<Object> get props => [];
}

class FormInteractionInitial extends FormInteractionState {
  const FormInteractionInitial();
}

class FormInteractionRegister extends FormInteractionState {
  const FormInteractionRegister();
}

class FormInteractionEdit extends FormInteractionState {
  const FormInteractionEdit();
}

class FormInteractionDelete extends FormInteractionState {
  const FormInteractionDelete();
}
