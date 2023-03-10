import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/core/socket/event/socket_event_listener.dart';
import 'package:amity_sdk/src/data/converter/create_comment_response_extension.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

///[CommentEventListener]
abstract class CommentEventListener extends SocketEventListener {
  @override
  void processEvent(Map<String, dynamic> json) {
    final data = CreateCommentResponse.fromJson(json);

    data.saveToDb(serviceLocator());
  }

  @override
  bool shouldProcessEvent(Map<String, dynamic> json) {
    final data = CreateCommentResponse.fromJson(json);
    if (data.comments.isNotEmpty) {
      return _hasLocalComment(data.comments[0].commentId);
    } else {
      return false;
    }
  }

  bool _hasLocalComment(String messageId) {
    return serviceLocator<CommentHasLocalUseCase>().get(messageId);
  }
}
