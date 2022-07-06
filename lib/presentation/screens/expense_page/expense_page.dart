import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:projeto_controle_financeiro/business_logic/cubit/form/form_interaction_cubit.dart';

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
          BlocProvider(create: (context) => ExpenseValidationCubit()),
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
  final Map<String, String?> _formData = {};
  final _expirationDateController = TextEditingController();
  final _descriptionFocusNode = FocusNode();
  final _valueFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();
  final _classificationFocusNode = FocusNode();
  final _expirationDateFocusNode = FocusNode();
  bool _isEditPage = false;

  String _appBarTitle = 'Despesa';
  String _textButton = 'Cadastrar Despesa';

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  void dispose() {
    _expirationDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
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
                    initialValue: _formData['description'],
                    isEditPage: _isEditPage,
                    focusNode: _descriptionFocusNode,
                    nextFocusNode: _valueFocusNode,
                    onChanged: (description) {
                      _formData['description'] = description;
                      context
                          .read<ExpenseValidationCubit>()
                          .validateIncomeForm(_formData);
                    }),
                const SizedBox(
                  height: 16,
                ),
                _ValueInput(
                    initialValue: _formData['value'],
                    focusNode: _valueFocusNode,
                    nextFocusNode: _typeFocusNode,
                    onChanged: (value) {
                      final newValue = value
                          .replaceAll('R\$', '')
                          .replaceAll(',', "")
                          .trim();
                      _formData['value'] = newValue;
                      context
                          .read<ExpenseValidationCubit>()
                          .validateIncomeForm(_formData);
                    }),
                const SizedBox(
                  height: 16,
                ),
                _TypeInput(
                  initialValue: _formData['type'],
                  focusNode: _typeFocusNode,
                  onChanged: (type) {
                    _formData['type'] = type;
                    context
                        .read<ExpenseValidationCubit>()
                        .validateIncomeForm(_formData);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                _ClassificationInput(
                  initialValue: _formData['classification'],
                  focusNode: _classificationFocusNode,
                  onChanged: (classification) {
                    _formData['classification'] = classification;
                    context
                        .read<ExpenseValidationCubit>()
                        .validateIncomeForm(_formData);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                _ExpirationDateInput(
                    controller: _expirationDateController,
                    formData: _formData,
                    focusNode: _expirationDateFocusNode,
                    onTap: () async {
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
                        setState(() {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          _expirationDateController.text = formattedDate;
                          _formData['expiration-date'] =
                              _expirationDateController.text;
                        });
                      }
                    }),
                const SizedBox(
                  height: 16,
                ),
                _ExpenseFormButton(
                  formData: _formData,
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
      _formData['description'] = '';
      _formData['value'] = '';
      _expirationDateController.text = '';
      BlocProvider.of<FormInteractionCubit>(context, listen: false)
          .formRegister();
    } else {
      _isEditPage = true;
      _textButton = 'Editar Despesa';
      _appBarTitle = widget.expense!.description;
      BlocProvider.of<FormInteractionCubit>(context, listen: false).formEdit();

      _formData['description'] = widget.expense!.description;
      _formData['value'] = AppNumberFormat.getCurrency(widget.expense!.value);
      _formData['type'] = typeEnumMap[widget.expense!.type]!;
      _formData['classification'] =
          classificationEnumMap[widget.expense!.classification]!;

      if (widget.expense!.expirationDate != null) {
        _expirationDateController.text =
            DateFormat('dd/MM/yyyy').format(widget.expense!.expirationDate!);
        _formData['expiration-date'] = _expirationDateController.text;
      } else {
        _expirationDateController.text = '';
        _formData['expiration-date'] = '';
      }
    }
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
                      CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
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
                      CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
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
                      CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
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
  final String? initialValue;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final Function(String)? onChanged;
  final bool isEditPage;

  const _DescriptionInput(
      {Key? key,
      required this.initialValue,
      required this.focusNode,
      this.nextFocusNode,
      required this.onChanged,
      required this.isEditPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseValidationCubit, ExpenseValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          autofocus: isEditPage ? false : true,
          initialValue: initialValue,
          focusNode: focusNode,
          onEditingComplete: nextFocusNode!.requestFocus,
          onChanged: onChanged,
          labelText: 'Descrição',
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (state is ExpenseValidating) {
              return state.descriptionInput?.onError;
            } else {
              return null;
            }
          },
        );
      },
    );
  }
}

class _ValueInput extends StatelessWidget {
  final String? initialValue;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final Function(String)? onChanged;

  const _ValueInput({
    Key? key,
    required this.focusNode,
    this.nextFocusNode,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseValidationCubit, ExpenseValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyTextFormatter()
          ],
          initialValue: initialValue,
          focusNode: focusNode,
          onChanged: onChanged,
          onEditingComplete: nextFocusNode!.requestFocus,
          labelText: 'Valor',
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (state is ExpenseValidating) {
              return state.valueInput?.onError;
            } else {
              return null;
            }
          },
        );
      },
    );
  }
}

class _TypeInput extends StatelessWidget {
  final String? initialValue;
  final FocusNode focusNode;
  final Function(String?)? onChanged;

  const _TypeInput({
    Key? key,
    required this.initialValue,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseValidationCubit, ExpenseValidationState>(
      builder: (context, state) {
        return CustomDropDownButton(
            initialValue: initialValue,
            hintText: 'Tipo',
            items: <String>[
              typeEnumMap[Type.fixed]!,
              typeEnumMap[Type.nonFixed]!
            ],
            onChanged: onChanged,
            width: double.maxFinite,
            height: 52);
      },
    );
  }
}

class _ClassificationInput extends StatelessWidget {
  final String? initialValue;
  final FocusNode focusNode;
  final Function(String?)? onChanged;

  const _ClassificationInput({
    Key? key,
    required this.initialValue,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseValidationCubit, ExpenseValidationState>(
      builder: (context, state) {
        return CustomDropDownButton(
            initialValue: initialValue,
            hintText: 'Classificação',
            items: <String>[
              classificationEnumMap[Classification.essential]!,
              classificationEnumMap[Classification.nonEssential]!
            ],
            onChanged: onChanged,
            width: double.maxFinite,
            height: 52);
      },
    );
  }
}

class _ExpirationDateInput extends StatelessWidget {
  final String? initialValue;
  final TextEditingController controller;
  final Map<String, String?> formData;

  final Function()? onTap;

  final FocusNode focusNode;
  const _ExpirationDateInput(
      {Key? key,
      this.initialValue,
      required this.controller,
      required this.formData,
      required this.focusNode,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      labelText: 'Data de Vencimento',
      focusNode: focusNode,
      prefixIcon: const Icon(
        Icons.calendar_today,
        color: AppColors.primaryDarkColor,
      ),
      readOnly: true,
      onTap: onTap,
    );
  }
}

class _ExpenseFormButton extends StatelessWidget {
  final Map<String, String?> formData;
  final String buttonLabel;
  final String? expenseId;

  const _ExpenseFormButton({
    Key? key,
    required this.formData,
    required this.buttonLabel,
    this.expenseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return BlocBuilder<ExpenseValidationCubit, ExpenseValidationState>(
      builder: (context, state) {
        return CustomElevatedButton(
            buttonLabel: buttonLabel,
            onPressed: state is ExpenseValidated
                ? () {
                    FocusScope.of(context).unfocus();
                    final expense = Expense(
                        id: expenseId,
                        description: formData['description']!,
                        value: double.parse(formData['value']!) / 100,
                        classification:
                            stringToClassification[formData['classification']]!,
                        type: stringToType[formData['type']]!,
                        expirationDate: formData['expiration-date'] == ''
                            ? null
                            : DateFormat("dd/MM/yyyy")
                                .parse(formData['expiration-date']!),
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
