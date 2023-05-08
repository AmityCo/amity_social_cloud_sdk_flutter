import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:f2c24783-733e-4a4a-90c4-b518a8d584a1
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

  test('When user edit comment with wrong comment id, it should return not found error (400400).', () async {
    when(() => mockCommentApiInterface.updateComment(commentId, any<UpdateCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_update_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      await AmitySocialClient.newCommentRepository()
          .updateComment(commentId: commentId)
          .text('Update Comment')
          .build()
          .update();
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400400);
    }
  });
}
