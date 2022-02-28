import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/model/api_request/reaction_request.dart';
import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/reaction_api_interface.dart';
import 'package:dio/dio.dart';

class ReactionApiInterfaceImpl extends ReactionApiInterface {
  final HttpApiClient httpApiClient;

  ReactionApiInterfaceImpl({required this.httpApiClient});
  @override
  Future<String> addReaction(ReactionRequest request) async {
    try {
      final data = await httpApiClient().post(
        REACTION_V2_URL,
        data: request,
      );
      return data.data['addedId'];
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<String> removeReaction(ReactionRequest request) async {
    try {
      final data = await httpApiClient().delete(
        REACTION_V2_URL,
        data: request,
      );
      return data.data['removedId'];
    } on DioError catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
