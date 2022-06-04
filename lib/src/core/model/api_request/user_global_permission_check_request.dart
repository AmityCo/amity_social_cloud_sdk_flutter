import 'package:amity_sdk/amity_sdk.dart';

class UserGlobalPermissionCheckRequest {
  final String userId;
  final AmityPermission permission;

  UserGlobalPermissionCheckRequest(
      {required this.userId, required this.permission});
}
