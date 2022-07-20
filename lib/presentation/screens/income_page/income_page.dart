import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_controle_financeiro/themes/app_colors.dart';

import '../../../business_logic/business_logic.dart';
import '../../widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../../data/models/models.dart';

class IncomePage extends StatelessWidget {
  final Income? income;
  const IncomePage({Key? key, this.income}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: BlocProvider.of<IncomeCubit>(context)),
          BlocProvider(create: (context) => IncomeValidationCubit()),
          BlocProvider(create: (context) => FormInteractionCubit())
        ],
        child: IncomeForm(
          income: income,
        ));
  }
}

class IncomeForm extends StatefulWidget {
  final Income? income;
  const IncomeForm({Key? key, this.income}) : super(key: key);

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final Map<String, String?> _formData = {};
  bool _isEditPage = false;

  final _descriptionFocusNode = FocusNode();
  final _valueFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();

  String _appBarTitle = 'Renda';
  String _textButton = 'Cadastrar Renda';

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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        actions: _isEditPage
            ? [
                IconButton(
                    onPressed: () {
                      final incomeId = widget.income?.id;
                      context.read<IncomeCubit>().deleteIncome(incomeId!);
                      BlocProvider.of<FormInteractionCubit>(context,
                              listen: false)
                          .formDelete();
                    },
                    icon: const Icon(Icons.delete)),
              ]
            : [],
      ),
      body: BlocListener<IncomeCubit, IncomeState>(
        listener: (context, state) {
          if (state is IncomeInitial) {
            const SizedBox();
          } else if (state is IncomeLoading) {
            _showAlertDialog(context);
          } else if (state is IncomeSuccess) {
            Navigator.pop(context);
            _showSnackBar(context);
            Navigator.pop(context);
            context.read<IncomeCubit>().getAllIncomes();
            context.read<InformationPanelCubit>().informationPanelCalculated();
          } else if (state is IncomeLoaded) {
            Navigator.pop(context);
          } else if (state is IncomeFailure) {
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
                focusNode: _descriptionFocusNode,
                nextFocusNode: _valueFocusNode,
                isEditPage: _isEditPage,
                onChanged: (description) {
                  _formData['description'] = description;
                  context
                      .read<IncomeValidationCubit>()
                      .validateIncomeForm(_formData);
                },
              ),
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
                      .replaceAll(RegExp('[^0-9]'), "")
                      .trim();
                  _formData['value'] = newValue;
                  context
                      .read<IncomeValidationCubit>()
                      .validateIncomeForm(_formData);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              _TypeInput(
                initialValue: _formData['type'],
                focusNode: _typeFocusNode,
                onChanged: (type) {
                  _formData['type'] = type;
                  context
                      .read<IncomeValidationCubit>()
                      .validateIncomeForm(_formData);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              _IncomeFormButton(
                  buttonLabel: _textButton,
                  incomeId: widget.income?.id,
                  formData: _formData)
            ],
          ),
        ),
      ),
    );
  }

  _initState() {
    if (widget.income == null) {
      _formData['description'] = '';
      _formData['value'] = '';
      BlocProvider.of<FormInteractionCubit>(context).formRegister();
    } else {
      _isEditPage = true;
      _textButton = 'Editar Renda';
      _appBarTitle = widget.income!.description;
      BlocProvider.of<FormInteractionCubit>(context).formEdit();
      _formData['description'] = widget.income!.description;
      _formData['value'] = AppNumberFormat.getCurrency(widget.income!.value);
      _formData['type'] = typeEnumMap[widget.income!.type]!;
    }
  }

  _showSnackBar(BuildContext context) {
    final state = BlocProvider.of<FormInteractionCubit>(context).state;

    if (state is FormInteractionRegister) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('Renda cadastrada com sucesso!'),
          backgroundColor: AppColors.informationSuccessColor,
        ));
    } else if (state is FormInteractionEdit) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('Renda editada com sucesso!'),
          backgroundColor: AppColors.informationSuccessColor,
        ));
    } else if (state is FormInteractionDelete) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text('Renda excluída com sucesso!'),
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
    return BlocBuilder<IncomeValidationCubit, IncomeValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          initialValue: initialValue,
          autofocus: isEditPage ? false : true,
          validator: (value) {
            if (state is IncomeValidating) {
              return state.descriptionInput?.onError;
            } else {
              return null;
            }
          },
          focusNode: focusNode,
          onEditingComplete: nextFocusNode!.requestFocus,
          onChanged: onChanged,
          labelText: 'Descrição',
          textInputAction: TextInputAction.next,
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

  const _ValueInput(
      {Key? key,
      required this.initialValue,
      required this.focusNode,
      this.nextFocusNode,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeValidationCubit, IncomeValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyTextFormatter()
          ],
          labelText: 'Valor',
          initialValue: initialValue,
          focusNode: focusNode,
          validator: (value) {
            if (state is IncomeValidating) {
              return state.valueInput?.onError;
            } else {
              return null;
            }
          },
          onEditingComplete: nextFocusNode!.requestFocus,
          onChanged: onChanged,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
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
    return BlocBuilder<IncomeValidationCubit, IncomeValidationState>(
      builder: (context, state) {
        return CustomDropDownButton(
            hintText: 'Tipo',
            initialValue: initialValue,
            items: <String>[
              typeEnumMap[Type.fixed]!,
              typeEnumMap[Type.nonFixed]!,
            ],
            onChanged: onChanged,
            width: double.maxFinite,
            height: 52);
      },
    );
  }
}

class _IncomeFormButton extends StatelessWidget {
  final Map<String, String?> formData;
  final String buttonLabel;
  final String? incomeId;

  const _IncomeFormButton({
    Key? key,
    required this.formData,
    this.incomeId,
    required this.buttonLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocBuilder<IncomeValidationCubit, IncomeValidationState>(
      builder: (context, state) {
        return CustomElevatedButton(
            buttonLabel: buttonLabel,
            onPressed: state is IncomeValidated
                ? () {
                    FocusScope.of(context).unfocus();
                    final income = Income(
                        id: incomeId,
                        description: formData['description']!,
                        value: double.parse(formData['value']!),
                        type: stringToType[formData['type']]!,
                        user: user);
                    context.read<IncomeCubit>().saveIncome(income);
                  }
                : null,
            width: double.maxFinite,
            height: 52);
      },
    );
  }
}
