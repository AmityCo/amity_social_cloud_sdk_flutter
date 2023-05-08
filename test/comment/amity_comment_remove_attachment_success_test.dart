import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:b50d7783-ab5e-4473-be3b-08ffe8b5142a
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final commentId = 'commentId';

  setUpAll(() async {
    registerFallbackValue(UpdateCommentRequest(commentId: commentId));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });

  test('When user removes attachment to existing comment with attachment, it should return success', () async {
    when(() => mockCommentApiInterface.updateComment(commentId, any<UpdateCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_remove_attachment_success.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComment = await AmitySocialClient.newCommentRepository()
        .updateComment(commentId: commentId)
        .text('updataed comment text')
        .build()
        .update();

    expect(amityComment, isA<AmityComment>());
    expect(amityComment.dataTypes!.contains(AmityDataType.TEXT.value), true);
  });
}
