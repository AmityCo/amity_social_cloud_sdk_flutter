import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}


// integration_test_id:015838a8-3267-4253-920a-9ae83197cf22

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final postId = 'postId';

  setUpAll(() async {
    registerFallbackValue(
        CreateCommentRequest(referenceId: postId, referenceType: AmityCommentReferenceType.POST.value));

    await AmityCoreClientMockSetup.setup();

    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });


  test('When user create comment with text and image, it should return success', () async {

    when(() => mockCommentApiInterface.createComment(any<CreateCommentRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_comment_create_with_mention_test.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComment = await AmitySocialClient.newCommentRepository()
        .createComment()
        .post(postId)
        .create()
        .text('Create Comment')
        .mentionUsers(['userId1', 'userId2'])
        .send();

    expect(amityComment, isA<AmityComment>());
    expect(amityComment.mentionees?.length??0, 2);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}