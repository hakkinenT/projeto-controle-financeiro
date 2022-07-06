part of 'general_app_cubit.dart';

class GeneralAppState extends Equatable {
  const GeneralAppState(
      {required this.isEditingForm, required this.isDeletingForm});

  final bool isEditingForm;
  final bool isDeletingForm;

  GeneralAppState copyWith({bool? isEditingForm, bool? isDeletingForm}) {
    return GeneralAppState(
        isEditingForm: isEditingForm ?? this.isEditingForm,
        isDeletingForm: isDeletingForm ?? this.isDeletingForm);
  }

  @override
  List<Object> get props => [isEditingForm];
}
