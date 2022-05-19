import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_community_members_request.dart';
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
          COMMUNITY_V3 + '/${request.communityId}/' + USERS,
          queryParameters: request.toJson());
      return GetCommunityMembersResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
