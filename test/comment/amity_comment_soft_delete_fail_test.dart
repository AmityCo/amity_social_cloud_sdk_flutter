import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:322954d6-bc89-40ae-bd18-691ee0c60105
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final commentId = '64588aecb7720e7875bcabbe';

  setUpAll(() async {
    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });

  test('When user soft-deletes comment with wrong id, it should return not found error (400400).', () async {
    when(() => mockCommentApiInterface.getComment(commentId))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_comment_get_success.json')
              .readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    when(() => mockCommentApiInterface.deleteComment(commentId))
        .thenAnswer((_) async {
          final response =
          await File('test/mock_json/amity_comment_hard_deleted_fail.json')
              .readAsString();
          throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });
    final amityComment = await AmitySocialClient.newCommentRepository()
        .getComment(commentId: commentId);

    try {
    final isSoftDeleted= await amityComment.delete(hardDelete: false);
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400400);
    }
  });
}
