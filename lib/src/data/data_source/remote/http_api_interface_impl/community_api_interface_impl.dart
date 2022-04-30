import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

class CommunityApiInterfaceImpl extends CommunityApiInterface {
  CommunityApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;

  @override
  Future<CreateCommunityResponse> createCommunity(
      CreateCommunityRequest request) async {
    try {
      final data = await httpApiClient().post(COMMUNITY_V3);
      return CreateCommunityResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateCommunityResponse> getCommunityById(String communityId) async {
    try {
      final data = await httpApiClient().get(COMMUNITY_V3 + '/$communityId');
      return CreateCommunityResponse.fromJson(data.data);
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
