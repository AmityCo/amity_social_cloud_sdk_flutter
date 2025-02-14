import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:dio/dio.dart';

/// [MessageApiInterfaceImpl]
class MessageApiInterfaceImpl extends MessageApiInterface {
  /// Init Message  api client
  MessageApiInterfaceImpl({required this.httpApiClient});

  /// Http clinet to make API request
  final HttpApiClient httpApiClient;
  @override
  Future<CreateMessageResponse> messageQuery(
      MessageQueryRequest request) async {
    try {
      final data = await httpApiClient()
          .get(MESSAGE_V5, queryParameters: request.toJson());
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateMessageResponse> createMessage(
      CreateMessageRequest request) async {
    try {
      final data =
          await httpApiClient().post(MESSAGE_V5, data: request.toJson());
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateMessageResponse> updateMessage(
      CreateMessageRequest request) async {
    try {
      final data = await httpApiClient()
          .put('$MESSAGE_V5/${request.messageId}', data: request.toJson());
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateMessageResponse> deleteMessage(String messageId) async {
    try {
     final data = await httpApiClient()
          .delete('$MESSAGE_V5/$messageId', data: {'messageId': messageId});
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateMessageResponse> getMessage(String messageId) async {
    try {
      final data = await httpApiClient().get(
        '$MESSAGE_V5/$messageId',
      );
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future isFlaggedByMe(String messageId) async {
    try {
      await httpApiClient().get('$MESSAGE_V5/$messageId/isFlaggedByMe',
          queryParameters: {'messageId': messageId});
      return;
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateMessageResponse> flagMessage(String messageId) async {
    try {
      final data = await httpApiClient()
          .post('$MESSAGE_V5/$messageId/flags', data: {'messageId': messageId});
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateMessageResponse> unFlagMessage(String messageId) async {
    try {
      final data = await httpApiClient().delete('$MESSAGE_V5/$messageId/flags',
          data: {'messageId': messageId});
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }


  @override
  Future<CreateMessageResponse> createMessageInFeed(String messageId) async {
    try {
      final data = await httpApiClient().delete('$MESSAGE_V5/$messageId/unflag',
          data: {'messageId': messageId});
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
