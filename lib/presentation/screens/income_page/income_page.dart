import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_controle_financeiro/form_validator/form_validator.dart';
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
          BlocProvider(create: (context) => IncomeFormCubit()),
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
  bool _isEditPage = false;

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
              _IncomeFormButton(
                buttonLabel: _textButton,
                incomeId: widget.income?.id,
              )
            ],
          ),
        ),
      ),
    );
  }

  _initState() {
    if (widget.income == null) {
      BlocProvider.of<FormInteractionCubit>(context).formRegister();
    } else {
      _isEditPage = true;
      _textButton = 'Editar Renda';
      _appBarTitle = widget.income!.description;
      BlocProvider.of<FormInteractionCubit>(context).formEdit();
      BlocProvider.of<IncomeFormCubit>(context).updateInputs(widget.income!);
    }

    BlocProvider.of<IncomeFormCubit>(context).formInputsListeners();
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
  final bool isEditPage;

  const _DescriptionInput({Key? key, required this.isEditPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeFormCubit, IncomeFormState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const ValueKey('textField_descriptionIncome'),
          initialValue: state.descriptionInput?.value,
          autofocus: isEditPage ? false : true,
          focusNode: state.descriptionFocusNode,
          onEditingComplete: state.descriptionFocusNode.nextFocus,
          onChanged: (description) {
            context.read<IncomeFormCubit>().descriptionChanged(description);
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
    return BlocBuilder<IncomeFormCubit, IncomeFormState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const ValueKey('textFiel_valueIncome'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyTextFormatter()
          ],
          labelText: 'Valor',
          initialValue: state.valueInput?.value,
          focusNode: state.valueFocusNode,
          onEditingComplete: state.valueFocusNode.nextFocus,
          onChanged: (value) {
            final newValue = value
                .replaceAll('R\$', '')
                .replaceAll(RegExp('[^0-9]'), "")
                .trim();

            context.read<IncomeFormCubit>().valueChanged(newValue);
          },
          validator: (String? value) {
            if (state.valueInput!.invalid) {
              return state.valueInput?.onError;
            } else {
              return null;
            }
          },
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          errorText:
              state.valueIsNotValidated! ? state.valueInput?.onError : null,
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
    return BlocBuilder<IncomeFormCubit, IncomeFormState>(
      builder: (context, state) {
        return CustomDropDownButton(
          key: const ValueKey('dropField_typeIncome'),
          onTap: () {
            state.typeFocusNode.requestFocus();
          },
          hintText: 'Tipo',
          initialValue: state.typeInput?.value,
          focusNode: state.typeFocusNode,
          items: <String>[
            typeEnumMap[Type.fixed]!,
            typeEnumMap[Type.nonFixed]!,
          ],
          onChanged: (type) {
            FocusScope.of(context).requestFocus(FocusNode());
            context.read<IncomeFormCubit>().typeChanged(type);

            state.typeFocusNode.nextFocus();
          },
          errorText:
              state.typeIsNotValidated! ? state.typeInput?.onError : null,
          width: double.maxFinite,
        );
      },
    );
  }
}

class _IncomeFormButton extends StatelessWidget {
  final String buttonLabel;
  final String? incomeId;

  const _IncomeFormButton({
    Key? key,
    this.incomeId,
    required this.buttonLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocBuilder<IncomeFormCubit, IncomeFormState>(
      builder: (context, state) {
        return CustomElevatedButton(
            buttonLabel: buttonLabel,
            onPressed: state.status == FormStatus.validated
                ? () {
                    FocusScope.of(context).unfocus();
                    final income = Income(
                        id: incomeId,
                        description: state.descriptionInput!.value,
                        value: double.parse(state.valueInput!.value),
                        type: stringToType[state.typeInput!.value]!,
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
