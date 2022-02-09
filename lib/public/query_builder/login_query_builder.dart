import 'package:amity_sdk/core/usercase/usecase.dart';
import 'package:amity_sdk/public/public.dart';

class LoginQueryBuilder {
  late UseCase _useCase;
  late String _userId;
  String? _displayName;
  String? _deviceId;

  LoginQueryBuilder({required UseCase useCase, required String userId}) {
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

  Future<AmityUser> submit() {
    throw UnimplementedError();
  }
}
