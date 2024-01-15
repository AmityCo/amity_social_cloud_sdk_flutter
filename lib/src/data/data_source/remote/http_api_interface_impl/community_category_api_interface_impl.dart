import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

class CommunityCategoryApiInterfaceImpl extends CommunityCategoryApiInterface {
  CommunityCategoryApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;

  @override
  Future<CreateCommunityResponse> communityCategoryQuery(
      GetCommunityCategoryRequest request) async {
    try {
      final data = await httpApiClient()
          .get(COMMUNITY_CATEGORY_V3, queryParameters: request.toJson());
      return CreateCommunityResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
  
  @override
  Future<CreateCommunityResponse> getCommunityCategory(String communityId) async  {
    try {
      final data = await httpApiClient()
          .get('$COMMUNITY_CATEGORY_V3/$communityId');
      return CreateCommunityResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
