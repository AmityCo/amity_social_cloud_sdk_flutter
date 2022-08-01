import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:uuid/uuid.dart';

/// Login Query Builder
class LoginQueryBuilder {
  late LoginUsecase _useCase;
  late String _userId;
  String? _displayName;
  String? _authToekn;

  /// Init Login Query Builder
  LoginQueryBuilder({required LoginUsecase useCase, required String userId}) {
    _useCase = useCase;
    _userId = userId;
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
  Future<AmityUser> submit() {
    AuthenticationRequest params = AuthenticationRequest(userId: _userId);
    if (_displayName != null) {
      params.displayName = _displayName;
    }

    if (_authToekn != null) {
      params.authToken = _authToekn;
    }

    // Generating unique id for each login session
    params.deviceId = const Uuid().v1();

    return _useCase.get(params);
  }
}
