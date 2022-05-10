abstract class IApiServices<T> {
  Future<void> add(T entity);
  Future<void> update(T entity);
  Future<void> delete(String id);
}
