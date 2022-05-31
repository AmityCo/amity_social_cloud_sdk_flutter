import 'package:amity_sdk/src/core/model/api_request/update_user_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/usecase/user/update_user_usecase.dart';

class UserUpdateQueryBuilder {
  final UpdateUserUsecase _useCase;
  final String _userId;
  late UpdateUserRequest _request;
  UserUpdateQueryBuilder(this._useCase, this._userId) {
    _request = UpdateUserRequest(userId: _userId);
  }

  UserUpdateQueryBuilder displayName(String displayName) {
    _request.displayName = displayName;
    return this;
  }

  UserUpdateQueryBuilder avatarFileId(String avatarFileId) {
    _request.avatarFileId = avatarFileId;
    return this;
  }

  UserUpdateQueryBuilder avatarCustomUrl(String avatarCustomUrl) {
    _request.avatarCustomUrl = avatarCustomUrl;
    return this;
  }

  UserUpdateQueryBuilder metadata(Map<String, dynamic> metadata) {
    _request.metadata = metadata;
    return this;
  }

  UserUpdateQueryBuilder roles(List<String> roles) {
    _request.roles = roles;
    return this;
  }

  UserUpdateQueryBuilder description(String description) {
    _request.description = description;
    return this;
  }

  Future<AmityUser> update() {
    return _useCase.get(_request);
  }
}
