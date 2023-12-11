import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

class ReactionApiInterfaceImpl extends ReactionApiInterface {
  final HttpApiClient httpApiClient;

  ReactionApiInterfaceImpl({required this.httpApiClient});

  @override
  Future<GetReactionResponse> getReaction(GetReactionRequest request) async {
    try {
      final data = await httpApiClient()
          .get(REACTION_V3_URL, queryParameters: request.toJson());
      return GetReactionResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<String> addReaction(ReactionRequest request) async {
    try {
      final data = await httpApiClient().post(REACTION_V2_URL, data: request);
      return data.data['addedId'];
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<String> removeReaction(ReactionRequest request) async {
    try {
      final data = await httpApiClient().delete(REACTION_V2_URL, data: request);
      return data.data['removedId'];
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
