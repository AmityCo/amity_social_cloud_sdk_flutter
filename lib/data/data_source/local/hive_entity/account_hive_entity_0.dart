import 'package:hive/hive.dart';

part 'account_hive_entity.g.dart';

@HiveType(typeId: 0)
class AccountHiveEntity extends HiveObject {
  String? id;
  String? userId;
  String? displayName;
  String? deviceId;
  bool? isActive;
  String? refreshToken;
  String? accessToken;
  String? lastInactiveChannelIdsQuery;
}
