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
          .get(MESSAGE_V3, queryParameters: request.toJson());
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
          await httpApiClient().post(MESSAGE_V3, data: request.toJson());
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
          .put('$MESSAGE_V3/${request.messageId}', data: request.toJson());
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future deleteMessage(String messageId) async {
    try {
      await httpApiClient()
          .delete('$MESSAGE_V3/$messageId', data: {'messageId': messageId});
      return;
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateMessageResponse> getMessage(String messageId) async {
    try {
      final data = await httpApiClient().get(
        '$MESSAGE_V3/$messageId',
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
      await httpApiClient().get('$MESSAGE_V3/$messageId/isFlaggedByMe',
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
          .post('$MESSAGE_V3/$messageId/flag', data: {'messageId': messageId});
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }

  @override
  Future<CreateMessageResponse> unFlagMessage(String messageId) async {
    try {
      final data = await httpApiClient().delete('$MESSAGE_V3/$messageId/unflag',
          data: {'messageId': messageId});
      return CreateMessageResponse.fromJson(data.data);
    } on DioException catch (error) {
      final amityError = AmityErrorResponse.fromJson(error.response!.data);
      return Future.error(amityError.amityException());
    }
  }
}
