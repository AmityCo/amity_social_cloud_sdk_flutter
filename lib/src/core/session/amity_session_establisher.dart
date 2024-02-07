import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:uuid/uuid.dart';

class AmitySessionEstablisher{
  
  late LoginUsecase _useCase;
  late String _userId;
  String? _displayName;
  String? _authToekn;


  AmitySessionEstablisher({required LoginUsecase useCase, required String userId}) {
    _useCase = useCase;
    _userId = userId;
  }

  AmitySessionEstablisher displayName(String displayName) {
    _displayName = displayName;
    return this;
  }

  AmitySessionEstablisher authToken(String authToken) {
    _authToekn = authToken;
    return this;
  }

  Future<AmityUser> submit() async {
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

    return amityUser;
  }

  
}