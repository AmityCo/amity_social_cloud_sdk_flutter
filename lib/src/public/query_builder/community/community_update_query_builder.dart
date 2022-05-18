import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class CommunityUpdateQueryBuilder {
  final CommunityUpdateUseCase usecase;
  final String communityId;
  //Optional Params
  String? _displayName;
  String? _description;
  bool? _isPublic = false;
  List<String>? _categoryIds;
  Map<String, String>? _metadata;
  List<String>? _userIds;
  String? _avatarFileId;
  bool? _needApprovalOnPostCreation;

  CommunityUpdateQueryBuilder(this.usecase, this.communityId);

  CommunityUpdateQueryBuilder displayName(String displayName) {
    _displayName = displayName;
    return this;
  }

  CommunityUpdateQueryBuilder description(String description) {
    _description = description;
    return this;
  }

  CommunityUpdateQueryBuilder isPublic(bool isPublic) {
    _isPublic = isPublic;
    return this;
  }

  CommunityUpdateQueryBuilder categoryIds(List<String> categoryIds) {
    _categoryIds = categoryIds;
    return this;
  }

  CommunityUpdateQueryBuilder metadata(Map<String, String> metadata) {
    _metadata = metadata;
    return this;
  }

  CommunityUpdateQueryBuilder userIds(List<String> userIds) {
    _userIds = userIds;
    return this;
  }

  CommunityUpdateQueryBuilder avatar(AmityImage avatar) {
    _avatarFileId = avatar.fileId;
    return this;
  }

  CommunityUpdateQueryBuilder isPostReviewEnabled(bool isPostReviewEnabled) {
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
