import 'package:amity_sdk/src/core/usercase/usecase.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class GetCurrentAccountUseCase extends UseCaseWithoutParam<AccountHiveEntity?> {
  GetCurrentAccountUseCase(
      {required this.accountRepo});
  final AccountRepo accountRepo;

  @override
  Future<AccountHiveEntity?> get() async {
    return Future.value(accountRepo.getAccounts().firstOrNull);
  }
}
