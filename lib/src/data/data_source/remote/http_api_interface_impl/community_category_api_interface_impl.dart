import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_community_category_request.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/community_category_api_interface.dart';
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
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
