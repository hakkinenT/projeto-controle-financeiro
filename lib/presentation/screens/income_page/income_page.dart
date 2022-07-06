import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_controle_financeiro/themes/app_colors.dart';

import '../../../business_logic/business_logic.dart';
import '../../widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../../data/models/models.dart';

class IncomePage extends StatelessWidget {
  final Income? income;
  final bool? isDetailsPage;
  const IncomePage({Key? key, this.income, this.isDetailsPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: BlocProvider.of<IncomeCubit>(context)),
          BlocProvider(create: (context) => IncomeValidationCubit())
        ],
        child: IncomeForm(
          income: income,
          isDetailsPage: isDetailsPage,
        ));
  }
}

class IncomeForm extends StatefulWidget {
  final Income? income;
  final bool? isDetailsPage;
  const IncomeForm({Key? key, this.income, this.isDetailsPage})
      : super(key: key);

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  String? _typeInitialValue;
  bool _isEditing = false;

  final _descriptionFocusNode = FocusNode();
  final _valueFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();

  String _appBarTitle = 'Renda';
  String _textButton = 'Cadastrar Renda';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.income == null) {
      _descriptionController.text = '';
      _valueController.text = '';
    } else {
      _textButton = 'Editar Renda';
      _appBarTitle = widget.income!.description;
      _descriptionController.text = widget.income!.description;
      _valueController.text = widget.income!.value.toString();
      _typeInitialValue = typeEnumMap[widget.income!.type];
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        leading: IconButton(
            onPressed: () {
              if (_descriptionController.text != '' ||
                  _valueController.text != '') {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Cancelar Cadastro'),
                          content: const Text(
                              'Tem certeza que deseja cancelar o cadastro?'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Não')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Sim'))
                          ],
                        ));
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.close)),
        actions: widget.isDetailsPage!
            ? [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      final incomeId = widget.income?.id;
                      context.read<IncomeCubit>().deleteIncome(incomeId!);
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
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
          } else if (state is IncomeSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                  content: Text('Cadastro realizado com sucesso!')));
            Navigator.pop(context);
            context.read<IncomeCubit>().getAllIncomes();
          } else if (state is IncomeLoaded) {
            Navigator.pop(context);
          } else if (state is IncomeFailure) {
            customAlertDialog(
                context: context,
                title: 'Erro',
                message: state.message,
                informationIcon: Icons.check_circle,
                informationColor: AppColors.informationSuccessColor,
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'))
                ]);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _DescriptionInput(
                    controller: _descriptionController,
                    focusNode: _descriptionFocusNode,
                    nextFocusNode: _valueFocusNode,
                    onChanged: (desciption) {
                      context.read<IncomeValidationCubit>().validateIncomeForm(
                          _descriptionController.text,
                          _valueController.text,
                          _typeInitialValue);
                    },
                    readOnly: widget.isDetailsPage! && _isEditing == false
                        ? true
                        : false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _ValueInput(
                    controller: _valueController,
                    focusNode: _valueFocusNode,
                    nextFocusNode: _typeFocusNode,
                    onChanged: (desciption) {
                      context.read<IncomeValidationCubit>().validateIncomeForm(
                          _descriptionController.text,
                          _valueController.text,
                          _typeInitialValue);
                    },
                    readOnly: widget.isDetailsPage! && _isEditing == false
                        ? true
                        : false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _TypeInput(
                    initialValue: _typeInitialValue,
                    focusNode: _typeFocusNode,
                    onChanged: (type) {
                      setState(() {
                        _typeInitialValue = type;
                      });
                      context.read<IncomeValidationCubit>().validateIncomeForm(
                          _descriptionController.text,
                          _valueController.text,
                          _typeInitialValue);
                    },
                    enabled: widget.isDetailsPage! && _isEditing == false
                        ? false
                        : true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  widget.isDetailsPage! && _isEditing == false
                      ? const SizedBox()
                      : _IncomeFormButton(
                          buttonLabel: _textButton,
                          incomeId: widget.income?.id,
                          descriptionController: _descriptionController,
                          valueController: _valueController,
                          typeValue: _typeInitialValue,
                        )
                ],
              )),
        ),
      ),
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final bool readOnly;

  final Function(String)? onChanged;

  const _DescriptionInput(
      {Key? key,
      required this.controller,
      required this.focusNode,
      this.nextFocusNode,
      required this.readOnly,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeValidationCubit, IncomeValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          readOnly: readOnly,
          controller: controller,
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
          onFieldSubmitted: (String value) {},
          labelText: 'Descrição',
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class _ValueInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final bool readOnly;

  final Function(String)? onChanged;

  const _ValueInput(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.readOnly,
      this.nextFocusNode,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeValidationCubit, IncomeValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          labelText: 'Valor',
          controller: controller,
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
          onFieldSubmitted: (String value) {},
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          readOnly: readOnly,
        );
      },
    );
  }
}

class _TypeInput extends StatelessWidget {
  final String? initialValue;
  final FocusNode focusNode;
  final Function(String?)? onChanged;
  final bool enabled;

  const _TypeInput(
      {Key? key,
      required this.initialValue,
      required this.focusNode,
      required this.onChanged,
      required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeValidationCubit, IncomeValidationState>(
      builder: (context, state) {
        return CustomDropDownButton(
            enabled: enabled,
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
  final String buttonLabel;
  final String? incomeId;
  final TextEditingController descriptionController;
  final TextEditingController valueController;
  final String? typeValue;

  const _IncomeFormButton(
      {Key? key,
      this.incomeId,
      required this.buttonLabel,
      required this.descriptionController,
      required this.valueController,
      required this.typeValue})
      : super(key: key);

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
                        description: descriptionController.text,
                        value: double.parse(valueController.text),
                        type: stringToType[typeValue]!,
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
