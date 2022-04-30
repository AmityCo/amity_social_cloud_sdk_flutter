import 'package:amity_sdk/src/domain/model/amity_user.dart';

class AmityMentionee {
  late String _userId;
  AmityUser? _user;
  AmityMentionee({
    required String userId,
    AmityUser? user,
  }) {
    _userId = userId;
    _user = user;
  }
}
