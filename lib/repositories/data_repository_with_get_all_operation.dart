import 'repositories.dart';

abstract class DataRepositoryWithGetAllOperation<T>
    with GetAllOperationMixin<T>
    implements IApiServices<T> {}
