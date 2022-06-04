abstract class UseCase<Type, Params> {
  Future<Type> get(Params params);
  Stream<Type> listen(Params params);
}

abstract class UseCaseWithoutParam<Type> {
  Future<Type> get();
  Stream<Type> listen();
}

abstract class SynchronousUseCase<Type, Params> {
  Type get(Params params);
}
