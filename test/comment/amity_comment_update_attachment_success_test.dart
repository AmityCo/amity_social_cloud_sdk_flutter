import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:75c77684-09f3-442e-8089-6d37e2182a65
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final commentId = 'commentId';
  final attachments = [
    CommentImageAttachment(fileId: 'a6b76af95a864f649743a1bbd05b469f'),
    CommentImageAttachment(fileId: 'a6b76af95a864f649743a1bbd05b469e'),
  ];

  setUpAll(() async {
    registerFallbackValue(UpdateCommentRequest(commentId: commentId));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });

  test('When user adds attachment to existing comment with attachment, it should return success', () async {
    when(() => mockCommentApiInterface.updateComment(commentId, any<UpdateCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_update_attachment_success.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComment = await AmitySocialClient.newCommentRepository()
        .updateComment(commentId: commentId)
        .text('Updated Comment')
        .attachments(attachments)
        .build()
        .update();

    expect(amityComment, isA<AmityComment>());
    expect(amityComment.dataTypes!.contains(AmityDataType.TEXT.value), true);
    expect(amityComment.dataTypes!.contains(AmityDataType.IMAGE.value), true);
  });
}
