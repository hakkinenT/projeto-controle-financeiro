import 'package:projeto_controle_financeiro/repositories/get_operation_mixin.dart';
import 'package:projeto_controle_financeiro/repositories/i_api_services.dart';

abstract class DataRepositoryWithGetOperation<T>
    with GetOperationMixin<T>
    implements IApiServices<T> {}
