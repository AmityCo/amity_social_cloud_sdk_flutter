import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:cb1bfe11-c11a-4324-aeb5-03370da820ad
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final postId = 'postId';
  final parentId = 'parentId';

  setUpAll(() async {
    registerFallbackValue(CreateCommentRequest(
        referenceId: postId, referenceType: AmityCommentReferenceType.POST.value, parentId: parentId));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });

  test('When the user create comment with parent id, it should return valid comment', () async {
    when(() => mockCommentApiInterface.createComment(any<CreateCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_create_with_parent_success_test.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComment = await AmitySocialClient.newCommentRepository()
        .createComment()
        .post(postId)
        .parentId(parentId)
        .create()
        .text('Create Comment')
        .send();

    expect(amityComment, isA<AmityComment>());
    expect(amityComment.referenceId, postId);
    expect(amityComment.parentId, parentId);
  });
}
