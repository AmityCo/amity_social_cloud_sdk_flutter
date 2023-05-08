import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:2f83eabc-46db-43d8-89c6-1b5339d6a273
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

  test('When the user create comment, it should return a valid comment.', () async {
    when(() => mockCommentApiInterface.createComment(any<CreateCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_create_with_text_success_test.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComment = await AmitySocialClient.newCommentRepository()
        .createComment()
        .post(postId)
        .create()
        .text('Create Comment')
        .send();

    expect(amityComment, isA<AmityComment>());
    expect(amityComment.dataTypes!.contains(AmityDataType.TEXT.value), true);
  });
}
