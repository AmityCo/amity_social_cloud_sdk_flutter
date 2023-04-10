// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
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

  @override
  Future<UsersResponse> updateUser(UpdateUserRequest request) async {
    try {
      final data = await httpApiClient().put(USERS_URL, data: request);
      return UsersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<UsersResponse> flag(String userId) async {
    try {
      final data = await httpApiClient().post(ME_FLAG + '/$userId');
      return UsersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<UsersResponse> unflag(String userId) async {
    try {
      final data = await httpApiClient().delete(ME_FLAG + '/$userId');
      return UsersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> block(String userId) async {
    try {
      final data = await httpApiClient().post(ME_BLOCK + '/$userId');
      return data.data['success'];
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> unblock(String userId) async {
    try {
      final data = await httpApiClient().delete(ME_BLOCK + '/$userId');
      return data.data['success'];
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
