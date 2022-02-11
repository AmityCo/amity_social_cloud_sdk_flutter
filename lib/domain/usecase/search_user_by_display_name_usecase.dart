import 'package:amity_sdk/core/usercase/usecase.dart';
import 'package:amity_sdk/domain/model/amity_user.dart';

class SearchUserByDisplayNameUsecase extends UseCase<List<AmityUser>,String>{
  @override
  Future<List<AmityUser>> get(String params) {
    throw UnimplementedError();
  }

  @override
  Stream<List<AmityUser>> listen(String params) {
    throw UnimplementedError();
  }
}