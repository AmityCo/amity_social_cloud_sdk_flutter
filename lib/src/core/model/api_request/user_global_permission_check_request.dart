import 'package:amity_sdk/src/core/core.dart';

class UserGlobalPermissionCheckRequest {
  final String userId;
  final AmityPermission permission;

  UserGlobalPermissionCheckRequest(
      {required this.userId, required this.permission});
}
