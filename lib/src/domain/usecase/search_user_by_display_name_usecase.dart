import 'package:amity_sdk/src/core/usercase/usecase.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';

class SearchUserByDisplayNameUsecase extends UseCase<List<AmityUser>, String> {
  @override
  Future<List<AmityUser>> get(String params) {
    throw UnimplementedError();
  }
}
