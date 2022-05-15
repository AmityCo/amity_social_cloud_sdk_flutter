import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityCreateQueryBuilder {
  final CommunityCreateUsecase usecase;
  final String displayName;

  //Optional Params
  String? _description;
  bool? _isPublic = false;
  List<String>? _categoryIds;
  Map<String, String>? _metadata;
  List<String>? _userIds;
  String? _avatarFileId;
  bool? _needApprovalOnPostCreation;

  CommunityCreateQueryBuilder(this.usecase, this.displayName);

  CommunityCreateQueryBuilder description(String description) {
    _description = description;
    return this;
  }

  CommunityCreateQueryBuilder isPublic(bool isPublic) {
    _isPublic = isPublic;
    return this;
  }

  CommunityCreateQueryBuilder categoryIds(List<String> categoryIds) {
    _categoryIds = categoryIds;
    return this;
  }

  CommunityCreateQueryBuilder metadata(Map<String, String> metadata) {
    _metadata = metadata;
    return this;
  }

  CommunityCreateQueryBuilder userIds(List<String> userIds) {
    _userIds = userIds;
    return this;
  }

  CommunityCreateQueryBuilder avatar(AmityImage avatar) {
    _avatarFileId = avatar.fileId;
    return this;
  }

  CommunityCreateQueryBuilder isPostReviewEnabled(bool isPostReviewEnabled) {
    _needApprovalOnPostCreation = isPostReviewEnabled;
    return this;
  }

  Future<AmityCommunity> create() async {
    CreateCommunityRequest request =
        CreateCommunityRequest(displayName: displayName);
    request.description = _description;
    request.isPublic = _isPublic;
    request.categoryIds = _categoryIds;
    request.metadata = _metadata;
    request.userIds = _userIds;
    request.avatarFileId = _avatarFileId;
    request.needApprovalOnPostCreation = _needApprovalOnPostCreation;

    return usecase.get(request);
  }
}
