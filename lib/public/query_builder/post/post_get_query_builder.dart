import 'package:amity_sdk/core/enum/amity_post_target_type.dart';
import 'package:amity_sdk/domain/model/amity_mentionee_target.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/domain/usecase/post/post_get_usecase.dart';
import 'package:amity_sdk/public/amity_core_client.dart';

class AmityPostGetTargetSelector {
  late PostGetUsecase _useCase;
  AmityPostGetTargetSelector({required PostGetUsecase useCase}) {
    _useCase = useCase;
  }

  AmityPostGetDataTypeSelector targetMe() {
    return AmityPostGetDataTypeSelector(
        useCase: _useCase,
        targetId: AmityCoreClient.getUserId(),
        targetType: AmityPostTargetType.USER);
  }

  AmityPostGetDataTypeSelector targetUser(String targetUser) {
    return AmityPostGetDataTypeSelector(
        useCase: _useCase,
        targetId: targetUser,
        targetType: AmityPostTargetType.USER);
  }

  AmityPostGetDataTypeSelector targetCommunity(String communityId) {
    return AmityPostGetDataTypeSelector(
        useCase: _useCase,
        targetId: communityId,
        targetType: AmityPostTargetType.COMMUNITY);
  }

  // PostGetQueryBuilder text(String text) {
  //   _text = text;
  //   return this;
  // }

  // Future post() {
  //   throw UnimplementedError();
  // }
}

//Target
// class AmityMyFeedPostCreator {}

// class AmityUserFeedPostCreator {
//   late String _userId;
//   AmityUserFeedPostCreator({required String userId}) {
//     _userId = userId;
//   }
// }

class AmityCommunityFeedPostCreator {}

class AmityPostGetDataTypeSelector {
  late PostGetUsecase _useCase;
  late String _targetId;
  late AmityPostTargetType _targetType;
  AmityPostGetDataTypeSelector(
      {required PostGetUsecase useCase,
      required String targetId,
      required AmityPostTargetType targetType}) {
    _useCase = useCase;
    _targetId = targetId;
    _targetType = targetType;
  }

  AmityTextPostCreator text(String text) {
    return AmityTextPostCreator(
        useCase: _useCase,
        targetId: _targetId,
        targetType: _targetType.value,
        text: text);
  }
}

class AmityTextPostCreator {
  late PostGetUsecase _useCase;
  late String _targetId;
  late String _targetType;
  late String? _text;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;
  AmityTextPostCreator(
      {required PostGetUsecase useCase,
      required String targetId,
      required String targetType,
      String? text}) {
    _useCase = useCase;
    _targetId = targetId;
    _targetType = targetType;
    _text = text;
  }

  Future<AmityPost> post() {
    throw UnimplementedError();
    // GetPostRequest request = GetPostRequest(
    //     targetType: _targetType, targetId: _targetId, dataType: null);

    // CreatePostData data = CreatePostData();
    // if (_text != null) data.text = _text;

    // // request.data = data;

    // return _useCase.get(request);
  }
}
