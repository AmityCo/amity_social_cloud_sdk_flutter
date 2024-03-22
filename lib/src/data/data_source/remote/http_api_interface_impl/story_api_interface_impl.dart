import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/create_stroy_request.dart';
import 'package:amity_sdk/src/core/model/api_request/get_stories_by_target_request.dart';
import 'package:amity_sdk/src/core/model/api_request/story_delete_by_id_request.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/data/data_source/remote/api_interface/story_api_interface.dart';
import 'package:amity_sdk/src/data/response/create_story_response.dart';
import 'package:amity_sdk/src/data/response/response.dart';
import 'package:dio/dio.dart';

class StoryApiInterfaceImpl extends StoryApiInterface {
  final HttpApiClient httpApiClient;

  StoryApiInterfaceImpl({required this.httpApiClient});

  @override
  Future<CreateStoryResponse> createStory(CreateStoryRequest request) async {
    try {
      final data = await httpApiClient().post(STORIES, data: request.toJson());
      return CreateStoryResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateStoryResponse> getStories(
      GetStoriesByTragetRequest request) async {
    try {
      final data =
          await httpApiClient().get(STORIES, queryParameters: request.toJson());
      return CreateStoryResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<bool> deleteStoryById(StoryDeleteByIdRequest params) async {
    try {
      final data = await httpApiClient().delete('$STORIES/${params.storyId}',
          queryParameters: {"permanent": params.permanentDelete});
      return true;
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
