import 'package:amity_sdk/src/core/enum/amity_permission_type.dart';
import 'package:amity_sdk/src/core/model/api_request/user_global_permission_check_request.dart';
import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/usecase/community/permission/user_global_permission_check_usecase.dart';

class AmityGlobalPermissionValidator {
  final AmityPermission _permission;
  final String _userId;

  AmityGlobalPermissionValidator(this._permission, this._userId);

  Future<bool> check() {
    return serviceLocator<UserGlobalPermissionCheckUsecase>().get(
        UserGlobalPermissionCheckRequest(
            userId: _userId, permission: _permission));
  }
}
