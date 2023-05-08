import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:7f411488-abba-46d1-8707-a1d8adbd7242
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final postId = 'postId';

  setUpAll(() async {
    registerFallbackValue(
        CreateCommentRequest(referenceId: postId, referenceType: AmityCommentReferenceType.POST.value));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });

  test('When the user create comment with not existed parent id, it should return not found error (400400).', () async {
    when(() => mockCommentApiInterface.createComment(any<CreateCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_create_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
      final amityComment = await AmitySocialClient.newCommentRepository()
          .createComment()
          .post(postId)
          .create()
          .text('Create Comment')
          .send();
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400400);
    }
  });
}
