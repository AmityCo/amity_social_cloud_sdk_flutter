import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_community_members_request.dart';
import 'package:amity_sdk/src/core/model/api_request/update_community_members_request.dart';
import 'package:amity_sdk/src/core/model/api_request/update_community_role_request.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/community_member_api_interface.dart';
import 'package:amity_sdk/src/data/response/get_community_members_response.dart';
import 'package:amity_sdk/src/data/response/response.dart';
import 'package:dio/dio.dart';

class CommunityMemberApiInterfaceImpl extends CommunityMemmberApiInterface {
  CommunityMemberApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;

  @override
  Future<GetCommunityMembersResponse> getCommunityMembers(
      GetCommunityMembersRequest request) async {
    try {
      final data = await httpApiClient().get(
          '$COMMUNITY_V3/${request.communityId}/$USERS',
          queryParameters: request.toJson());
      return GetCommunityMembersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<GetCommunityMembersResponse> joinCommunity(String communityId) async {
    try {
      final param = <String, String>{
        "communityId": communityId,
      };
      final data = await httpApiClient()
          .post('$COMMUNITY_V3/$communityId/$JOIN', data: param);
      return GetCommunityMembersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<GetCommunityMembersResponse> leaveCommunity(String communityId) async {
    try {
      final param = <String, String>{
        "communityId": communityId,
      };
      final data = await httpApiClient()
          .delete('$COMMUNITY_V3/$communityId/$LEAVE', data: param);
      return GetCommunityMembersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<GetCommunityMembersResponse> addMember(
      UpdateCommunityMembersRequest request) async {
    try {
      final data = await httpApiClient().post(
          '$COMMUNITY_V3/${request.communityId}/$USERS',
          data: request.toJson());
      return GetCommunityMembersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<GetCommunityMembersResponse> removeMember(
      UpdateCommunityMembersRequest request) async {
    try {
      final data = await httpApiClient().delete(
          '$COMMUNITY_V3/${request.communityId}/$USERS',
          data: request.toJson());
      return GetCommunityMembersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<GetCommunityMembersResponse> addRole(
      UpdateCommunityRoleRequest request) async {
    try {
      final data = await httpApiClient().post(
          '$COMMUNITY_V3/${request.communityId}/$USERS/$ROLES',
          data: request.toJson());
      return GetCommunityMembersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<GetCommunityMembersResponse> removeRole(
      UpdateCommunityRoleRequest request) async {
    try {
      final data = await httpApiClient().delete(
          '$COMMUNITY_V3/${request.communityId}/$USERS/$ROLES',
          data: request.toJson());
      return GetCommunityMembersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<GetCommunityMembersResponse> banMember(
      UpdateCommunityMembersRequest request) async {
    try {
      final data = await httpApiClient().put(
          '$COMMUNITY_V3/${request.communityId}/$USERS/$BAN',
          data: request.toJson());
      return GetCommunityMembersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<GetCommunityMembersResponse> unbanMember(
      UpdateCommunityMembersRequest request) async {
    try {
      final data = await httpApiClient().put(
          '$COMMUNITY_V3/${request.communityId}/$USERS/$UNBAN',
          data: request.toJson());
      return GetCommunityMembersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
