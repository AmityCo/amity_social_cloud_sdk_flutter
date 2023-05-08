import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:f31daa63-7214-400a-a7a1-d9b00d37137e
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final commentId = 'commentId';
  final attachments = List.generate(1, (index) => CommentImageAttachment(fileId: 'a6b76af95a864f649743a1bbd05b469f'));

  setUpAll(() async {
    registerFallbackValue(UpdateCommentRequest(commentId: commentId));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });

  test('When user removes text from image comment, it should return success', () async {
    when(() => mockCommentApiInterface.updateComment(commentId, any<UpdateCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_remove_text_success.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComment = await AmitySocialClient.newCommentRepository()
        .updateComment(commentId: commentId)
        .attachments(attachments)
        .build()
        .update();

    expect(amityComment, isA<AmityComment>());
    expect(amityComment.dataTypes!.contains(AmityDataType.IMAGE.value), true);
  });
}
