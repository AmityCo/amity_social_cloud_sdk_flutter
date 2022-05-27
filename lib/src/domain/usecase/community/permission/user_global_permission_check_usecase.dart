import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/user_global_permission_check_request.dart';
import 'package:amity_sdk/src/domain/domain.dart';

class UserGlobalPermissionCheckUsecase
    extends UseCase<bool, UserGlobalPermissionCheckRequest> {
  final UserRepo userRepo;

  UserGlobalPermissionCheckUsecase({required this.userRepo});

  @override
  Future<bool> get(UserGlobalPermissionCheckRequest params) {
    final permissions = userRepo.getPermissions(params.userId);
    final hasPermission = permissions.contains(params.permission.value);
    return Future.value(hasPermission);
  }

  @override
  Stream<bool> listen(UserGlobalPermissionCheckRequest params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
