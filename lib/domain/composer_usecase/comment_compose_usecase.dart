import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/model/amity_comment.dart';

class CommentComposeUsecase extends UseCase<AmityComment, AmityComment> {
  @override
  Future<AmityComment> get(AmityComment params) {
    //1. Fill the user data
    //2. Fill the child comment
    //3. Fill the reaction
    throw UnimplementedError();
  }

  @override
  Stream<AmityComment> listen(AmityComment params) {
    throw UnimplementedError();
  }
}
