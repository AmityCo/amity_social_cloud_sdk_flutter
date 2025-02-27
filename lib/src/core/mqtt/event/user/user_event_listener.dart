import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/converter/user/users_response_extension.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/usecase/user/user_has_local_usecase.dart';

abstract class UserEventListener extends MQTTEventListener {
  @override
  void processEvent(Map<String, dynamic> json) {
    final data = UsersResponse.fromJson(json);
    data.saveToDb(serviceLocator(), serviceLocator());
  }

  /// This method is used to check if the event should be processed or not.
  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = UsersResponse.fromJson(json);
    if (data.users.isNotEmpty) {
      return _hasInLocal(data.users[0].userId ?? "");
    } else {
      return false;
    }
  }

  bool _hasInLocal(String userId) {
    return serviceLocator<UserHasLocalUsecase>().get(userId);
  }
}
