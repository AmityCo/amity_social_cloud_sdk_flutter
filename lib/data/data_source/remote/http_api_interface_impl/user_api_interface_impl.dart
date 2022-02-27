import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:dio/dio.dart';

class UserApiInterfaceImpl extends UserApiInterface {
  UserApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;

  @override
  Future<UsersResponse> getUsers(UsersRequest request) async {
    try {
      final data = await httpApiClient().get(
        USERS_URL,
        queryParameters: request.toJson(),
      );
      return UsersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<UsersResponse> getUserById(String userId) async {
    try {
      final data = await httpApiClient().get(
        USERS_URL + '/$userId',
      );
      return UsersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
