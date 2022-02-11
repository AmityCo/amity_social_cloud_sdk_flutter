import 'package:amity_sdk/core/model/api_request/authentication_request.dart';
import 'package:amity_sdk/domain/usecase/login_usecase.dart';
import 'package:amity_sdk/public/public.dart';

class LoginQueryBuilder {
  late LoginUsecase _useCase;
  late String _userId;
  String? _displayName;
  String? _deviceId;
  String? _authToekn;

  LoginQueryBuilder({required LoginUsecase useCase, required String userId}) {
    _useCase = useCase;
    _userId = userId;
  }

  LoginQueryBuilder displayName(String displayName) {
    _displayName = displayName;
    return this;
  }

  LoginQueryBuilder deviceId(String deviceId) {
    _deviceId = deviceId;
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
    if (_deviceId != null) {
      params.deviceId = _deviceId;
    }
    if (_authToekn != null) {
      params.authToken = _authToekn;
    }
    return _useCase.get(params);
  }
}
