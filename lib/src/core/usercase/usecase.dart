abstract class UseCase<Type, Params> {
  Future<Type> get(Params params);
  // Stream<Type> listen(Params params);
}

abstract class UseCaseWithoutParam<Type> {
  Future<Type> get();
}

abstract class SynchronousUseCase<Type, Params> {
  Type get(Params params);
}
