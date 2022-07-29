import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:projeto_controle_financeiro/form_validator/form_validator.dart';

import '../../../data/models/models.dart';
import '../../../themes/themes.dart';
import '../../widgets/widgets.dart';
import '../../../business_logic/business_logic.dart';
import '../../../utils/utils.dart';

class ExpensePage extends StatelessWidget {
  final Expense? expense;

  const ExpensePage({Key? key, this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: BlocProvider.of<ExpenseCubit>(context)),
          BlocProvider(create: (context) => ExpenseFormCubit()),
          BlocProvider(create: (context) => FormInteractionCubit())
        ],
        child: ExpenseForm(
          expense: expense,
        ));
  }
}

class ExpenseForm extends StatefulWidget {
  final Expense? expense;

  const ExpenseForm({
    Key? key,
    this.expense,
  }) : super(key: key);

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  bool _isEditPage = false;

  String _appBarTitle = 'Despesa';
  String _textButton = 'Cadastrar Despesa';

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: _isEditPage
            ? [
                IconButton(
                    onPressed: () {
                      final expenseId = widget.expense?.id;
                      context.read<ExpenseCubit>().deleteExpense(expenseId!);
                      BlocProvider.of<FormInteractionCubit>(context,
                              listen: false)
                          .formDelete();
                    },
                    icon: const Icon(Icons.delete))
              ]
            : [],
      ),
      body: BlocListener<ExpenseCubit, ExpenseState>(
          listener: (context, state) {
            if (state is ExpenseInitial) {
              const SizedBox();
            } else if (state is ExpenseLoading) {
              _showAlertDialog(context);
            } else if (state is ExpenseSuccess) {
              Navigator.pop(context);
              _showSnackBar(context);

              Navigator.pop(context);
              context.read<ExpenseCubit>().getAllExpenses();
              context
                  .read<InformationPanelCubit>()
                  .informationPanelCalculated();
            } else if (state is ExpenseLoaded) {
              Navigator.pop(context);
            } else if (state is ExpenseFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.informationErrorColor,
                ));
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DescriptionInput(
                  isEditPage: _isEditPage,
                ),
                const SizedBox(
                  height: 16,
                ),
                const _ValueInput(),
                const SizedBox(
                  height: 16,
                ),
                const _TypeInput(),
                const SizedBox(
                  height: 16,
                ),
                const _ClassificationInput(),
                const SizedBox(
                  height: 16,
                ),
                const _ExpirationDateInput(),
                const SizedBox(
                  height: 16,
                ),
                _ExpenseFormButton(
                  buttonLabel: _textButton,
                  expenseId: widget.expense?.id,
                )
              ],
            ),
          )),
    );
  }

  _initState() {
    if (widget.expense == null) {
      BlocProvider.of<FormInteractionCubit>(context, listen: false)
          .formRegister();
    } else {
      _isEditPage = true;
      _textButton = 'Editar Despesa';
      _appBarTitle = widget.expense!.description;
      BlocProvider.of<FormInteractionCubit>(context, listen: false).formEdit();
      BlocProvider.of<ExpenseFormCubit>(context).updateInputs(widget.expense!);
    }

    BlocProvider.of<ExpenseFormCubit>(context).formInputsListeners();
  }

  _showSnackBar(BuildContext context) {
    final state = BlocProvider.of<FormInteractionCubit>(context).state;

    if (state is FormInteractionRegister) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('Despesa cadastrada com sucesso!'),
          backgroundColor: AppColors.informationSuccessColor,
        ));
    } else if (state is FormInteractionEdit) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('Despesa editada com sucesso!'),
          backgroundColor: AppColors.informationSuccessColor,
        ));
    } else if (state is FormInteractionDelete) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('Despesa excluída com sucesso!'),
          backgroundColor: AppColors.informationSuccessColor,
        ));
    } else {
      const SizedBox();
    }
  }

  _showAlertDialog(BuildContext context) async {
    final state = BlocProvider.of<FormInteractionCubit>(context).state;
    late Timer timer;

    if (state is FormInteractionRegister) {
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            timer = Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
            return AlertDialog(
                titlePadding: const EdgeInsets.all(25),
                title: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Cadastrando...')
                    ],
                  ),
                ));
          });
    } else if (state is FormInteractionEdit) {
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            timer = Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
            return AlertDialog(
                titlePadding: const EdgeInsets.all(25),
                title: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Editando...')
                    ],
                  ),
                ));
          });
    } else if (state is FormInteractionDelete) {
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            timer = Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
            return AlertDialog(
                titlePadding: const EdgeInsets.all(25),
                title: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Excluindo...')
                    ],
                  ),
                ));
          });
    } else {
      const SizedBox();
    }
    if (timer.isActive) {
      timer.cancel();
    }
  }
}

class _DescriptionInput extends StatelessWidget {
  final bool isEditPage;

  const _DescriptionInput({Key? key, required this.isEditPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const ValueKey('textField_descriptionExpense'),
          autofocus: isEditPage ? false : true,
          initialValue: state.descriptionInput?.value,
          focusNode: state.descriptionFocusNode,
          onEditingComplete: state.descriptionFocusNode.nextFocus,
          onChanged: (description) {
            context.read<ExpenseFormCubit>().descriptionChanged(description);
          },
          validator: (String? description) {
            if (state.descriptionInput!.invalid) {
              return state.descriptionInput?.onError;
            } else {
              return null;
            }
          },
          errorText: state.descriptionIsNotValidated!
              ? state.descriptionInput?.onError
              : null,
          labelText: 'Descrição',
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class _ValueInput extends StatelessWidget {
  const _ValueInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const ValueKey('textField_valueExpense'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyTextFormatter()
          ],
          initialValue: state.valueInput?.value,
          focusNode: state.valueFocusNode,
          onChanged: (value) {
            final newValue = value
                .replaceAll('R\$', '')
                .replaceAll(RegExp('[^0-9]'), "")
                .trim();
            context.read<ExpenseFormCubit>().valueChanged(newValue);
          },
          errorText:
              state.valueIsNotValidated! ? state.valueInput?.onError : null,
          onEditingComplete: state.valueFocusNode.nextFocus,
          labelText: 'Valor',
          validator: (String? value) {
            if (state.valueInput!.invalid) {
              return state.valueInput?.onError;
            } else {
              return null;
            }
          },
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        );
      },
    );
  }
}

class _TypeInput extends StatelessWidget {
  const _TypeInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      builder: (context, state) {
        return CustomDropDownButton(
          key: const ValueKey('dropField_typeExpense'),
          initialValue: state.typeInput?.value,
          focusNode: state.typeFocusNode,
          onTap: () {
            state.typeFocusNode.requestFocus();
          },
          hintText: 'Tipo',
          items: <String>[
            typeEnumMap[Type.fixed]!,
            typeEnumMap[Type.nonFixed]!
          ],
          onChanged: (type) {
            FocusScope.of(context).requestFocus(FocusNode());
            context.read<ExpenseFormCubit>().typeChanged(type);
            state.typeFocusNode.nextFocus();
          },
          width: double.maxFinite,
          errorText:
              state.typeIsNotValidated! ? state.typeInput?.onError : null,
        );
      },
    );
  }
}

class _ClassificationInput extends StatelessWidget {
  const _ClassificationInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      builder: (context, state) {
        return CustomDropDownButton(
          key: const ValueKey('dropField_classificationExpense'),
          initialValue: state.classificationInput?.value,
          focusNode: state.classificationFocusNode,
          onTap: () {
            state.classificationFocusNode.requestFocus();
          },
          hintText: 'Classificação',
          items: <String>[
            classificationEnumMap[Classification.essential]!,
            classificationEnumMap[Classification.nonEssential]!
          ],
          onChanged: (classification) {
            FocusScope.of(context).requestFocus(FocusNode());
            context
                .read<ExpenseFormCubit>()
                .classificationChanged(classification);
            context.read<ExpenseFormCubit>().changeExpirationDateFocus();
            state.classificationFocusNode.nextFocus();
          },
          errorText: state.classificationIsNotValidated!
              ? state.classificationInput?.onError
              : null,
          width: double.maxFinite,
        );
      },
    );
  }
}

class _ExpirationDateInput extends StatelessWidget {
  const _ExpirationDateInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      builder: (context, state) {
        return CustomTextFormField(
          controller: state.expirationDateInput,
          labelText: 'Data de Vencimento (Opcional)',
          focusNode: state.expirationDateFocusNode,
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: AppColors.primaryDarkColor,
          ),
          readOnly: true,
          onTap: () async {
            if (state.classificationIsNotValidated! == false) {
              state.expirationDateFocusNode.previousFocus();
            }
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    child: child!,
                    data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                            primary: AppColors.primaryColor,
                            onPrimary: AppColors.textColor,
                            onSurface: AppColors.textColor)),
                  );
                });
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('dd/MM/yyyy').format(pickedDate);
              context.read<ExpenseFormCubit>().setExpirationDate(formattedDate);
            }
            state.expirationDateFocusNode.nextFocus();
          },
        );
      },
    );
  }
}

class _ExpenseFormButton extends StatelessWidget {
  final String buttonLabel;
  final String? expenseId;

  const _ExpenseFormButton({
    Key? key,
    required this.buttonLabel,
    this.expenseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      builder: (context, state) {
        return CustomElevatedButton(
            buttonLabel: buttonLabel,
            onPressed: state.status == FormStatus.validated
                ? () {
                    FocusScope.of(context).unfocus();
                    final expense = Expense(
                        id: expenseId,
                        description: state.descriptionInput!.value,
                        value: double.parse(state.valueInput!.value),
                        classification: stringToClassification[
                            state.classificationInput!.value]!,
                        type: stringToType[state.typeInput!.value]!,
                        expirationDate: state.expirationDateInput?.text == null
                            ? null
                            : DateFormat("dd/MM/yyyy")
                                .parse(state.expirationDateInput!.text),
                        user: user);

                    context.read<ExpenseCubit>().saveExpense(expense);
                  }
                : null,
            width: double.maxFinite,
            height: 52);
      },
    );
  }
}
