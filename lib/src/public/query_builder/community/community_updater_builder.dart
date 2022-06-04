import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityUpdaterBuilder {
  final CommunityUpdateUseCase usecase;
  final String communityId;
  //Optional Params
  String? _displayName;
  String? _description;
  bool? _isPublic = false;
  List<String>? _categoryIds;
  Map<String, dynamic>? _metadata;
  List<String>? _userIds;
  String? _avatarFileId;
  bool? _needApprovalOnPostCreation;

  CommunityUpdaterBuilder(this.usecase, this.communityId);

  CommunityUpdaterBuilder displayName(String displayName) {
    _displayName = displayName;
    return this;
  }

  CommunityUpdaterBuilder description(String description) {
    _description = description;
    return this;
  }

  CommunityUpdaterBuilder isPublic(bool isPublic) {
    _isPublic = isPublic;
    return this;
  }

  CommunityUpdaterBuilder categoryIds(List<String> categoryIds) {
    _categoryIds = categoryIds;
    return this;
  }

  CommunityUpdaterBuilder metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  CommunityUpdaterBuilder userIds(List<String> userIds) {
    _userIds = userIds;
    return this;
  }

  CommunityUpdaterBuilder avatar(AmityImage avatar) {
    _avatarFileId = avatar.fileId;
    return this;
  }

  CommunityUpdaterBuilder isPostReviewEnabled(bool isPostReviewEnabled) {
    _needApprovalOnPostCreation = isPostReviewEnabled;
    return this;
  }

  Future<AmityCommunity> update() async {
    CreateCommunityRequest request =
        CreateCommunityRequest(communityId: communityId);

    request.displayName = _displayName;
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
