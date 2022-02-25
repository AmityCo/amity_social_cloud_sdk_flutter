import 'package:amity_sdk/core/enum/amity_post_target_type.dart';
import 'package:amity_sdk/core/model/api_request/create_post_request.dart';
import 'package:amity_sdk/domain/model/amity_mentionee_target.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/domain/usecase/post/post_create_usecase.dart';
import 'package:amity_sdk/public/amity_core_client.dart';

class AmityPostCreateTargetSelector {
  late PostCreateUsecase _useCase;
  AmityPostCreateTargetSelector({required PostCreateUsecase useCase}) {
    _useCase = useCase;
  }

  AmityPostCreateDataTypeSelector targetMe() {
    return AmityPostCreateDataTypeSelector(
        useCase: _useCase,
        userId: AmityCoreClient.getUserId(),
        targetType: AmityPostTargetType.USER);
  }

  AmityPostCreateDataTypeSelector targetUser(String targetUser) {
    return AmityPostCreateDataTypeSelector(
        useCase: _useCase,
        userId: targetUser,
        targetType: AmityPostTargetType.USER);
  }

  AmityCommunityFeedPostCreator targetCommunity(String communityId) {
    return AmityCommunityFeedPostCreator();
  }

  // PostCreateQueryBuilder text(String text) {
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

class AmityPostCreateDataTypeSelector {
  late PostCreateUsecase _useCase;
  late String _userId;
  late AmityPostTargetType _targetType;
  AmityPostCreateDataTypeSelector(
      {required PostCreateUsecase useCase,
      required String userId,
      required AmityPostTargetType targetType}) {
    _useCase = useCase;
    _userId = userId;
    _targetType = targetType;
  }

  AmityTextPostCreator text(String text) {
    return AmityTextPostCreator(
        useCase: _useCase,
        targetId: _userId,
        targetType: _targetType.value,
        text: text);
  }
}

class AmityTextPostCreator {
  late PostCreateUsecase _useCase;
  late String _targetId;
  late String _targetType;
  late String? _text;
  Map<String, dynamic>? _metadata;
  List<AmityMentioneeTarget>? _mentionees;
  AmityTextPostCreator(
      {required PostCreateUsecase useCase,
      required String targetId,
      required String targetType,
      String? text}) {
    _useCase = useCase;
    _targetId = targetId;
    _targetType = targetType;
    _text = text;
  }

  Future<AmityPost> post() {
    CreatePostRequest request = CreatePostRequest(
        targetType: _targetType, targetId: _targetId, dataType: null);

    CreatePostData data = CreatePostData();
    if (_text != null) data.text = _text;

    request.data = data;

    return _useCase.get(request);
  }
}
