import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';

class LoginQueryBuilder {
  late LoginUsecase _useCase;
  late String _userId;
  String? _displayName;
  String? _authToekn;

  LoginQueryBuilder({required LoginUsecase useCase, required String userId}) {
    _useCase = useCase;
    _userId = userId;
  }

  LoginQueryBuilder displayName(String displayName) {
    _displayName = displayName;
    return this;
  }

  LoginQueryBuilder authToken(String authToken) {
    _authToekn = authToken;
    return this;
  }

  Future<AmityUser> submit() {
    AuthenticationRequest params = AuthenticationRequest(userId: _userId);
    if (_displayName != null) {
      params.displayName = _displayName;
    }

    if (_authToekn != null) {
      params.authToken = _authToekn;
    }
    // Generating unique id for each login session
    params.deviceId = DateTime.now().millisecondsSinceEpoch.toString();
    return _useCase.get(params);
  }
}
