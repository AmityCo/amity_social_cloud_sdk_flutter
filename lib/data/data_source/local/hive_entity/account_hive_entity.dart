import 'package:hive/hive.dart';

part 'account_hive_entity.g.dart';

@HiveType(typeId: 3)
class AccountHiveEntity extends HiveObject {
  String? userId;
  String? displayName;
  String? deviceId;
  bool? isActive;
  String? refreshToken;
  String? accessToken;
  String? lastInactiveChannelIdsQuery;
}
