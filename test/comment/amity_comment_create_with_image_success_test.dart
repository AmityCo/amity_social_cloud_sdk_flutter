import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:81e7d5bc-6881-4f9b-b8d4-deb5fe67200c
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final postId = 'postId';

  final attachments = List.generate(1, (index) => CommentImageAttachment(fileId: 'eea9c113d8cf44b28d271390fb138f96'));

  setUpAll(() async {
    registerFallbackValue(
        CreateCommentRequest(referenceId: postId, referenceType: AmityCommentReferenceType.POST.value));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });

  test('When user create comment with only image, it should return success', () async {
    when(() => mockCommentApiInterface.createComment(any<CreateCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_create_with_image_success_test.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComment = await AmitySocialClient.newCommentRepository()
        .createComment()
        .post(postId)
        .create()
        .attachments(attachments)
        .send();

    expect(amityComment, isA<AmityComment>());
    expect(amityComment.attachments, isA<List<CommentAttachment>>());
    expect(amityComment.attachments?.length, 1);
    expect(amityComment.dataTypes!.contains(AmityDataType.IMAGE.value), true);
  });
}
