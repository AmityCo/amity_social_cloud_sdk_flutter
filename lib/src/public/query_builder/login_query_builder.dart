import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/session/event_bus/app_event_bus.dart';
import 'package:amity_sdk/src/core/session/event_bus/session_life_cycle_event_bus.dart';
import 'package:amity_sdk/src/core/session/model/app_event.dart';
import 'package:amity_sdk/src/core/session/model/session_life_cycle.dart';
import 'package:amity_sdk/src/data/mqtt/amity_mqtt.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:uuid/uuid.dart';

/// Login Query Builder
class LoginQueryBuilder {
  late LoginUsecase _useCase;
  late String _userId;
  String? _displayName;
  String? _authToekn;
  SessionLifeCycleEventBus? _sessionLifeCycleEventBus;
  AppEventBus? _appEventBus;

  /// Init Login Query Builder
  LoginQueryBuilder({required LoginUsecase useCase, required String userId , required SessionLifeCycleEventBus sessionLifeCycleEventBus , required AppEventBus appEventBus}) {
    _useCase = useCase;
    _userId = userId;
    _sessionLifeCycleEventBus = sessionLifeCycleEventBus;
    _appEventBus = appEventBus;
  }

  /// Add Dispplay Name
  LoginQueryBuilder displayName(String displayName) {
    _displayName = displayName;
    return this;
  }

  /// Add Auth Token
  LoginQueryBuilder authToken(String authToken) {
    _authToekn = authToken;
    return this;
  }

  /// Submit the Login Request
  Future<AmityUser> submit() async {
    _appEventBus!.publish(AppEvent.LoggingIn);
    AuthenticationRequest params = AuthenticationRequest(userId: _userId);
    if (_displayName != null) {
      params.displayName = _displayName;
    }

    if (_authToekn != null) {
      params.authToken = _authToekn;
    }

    // Generating unique id for each login session
    params.deviceId = const Uuid().v1();

    var amityUser = await _useCase.get(params);

    //TODO uncomment when ready
    //connect to socket if login is successful
    serviceLocator<AmitySocket>().connect();
    serviceLocator<AmityMQTT>().connect();
    _sessionLifeCycleEventBus!.publish(SessionLifeCycle.Establish);
    _appEventBus!.publish(AppEvent.LoginSuccess);

    ///

    return amityUser;
  }
}
