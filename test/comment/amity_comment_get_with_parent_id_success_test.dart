import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:8207d436-a800-4224-8fb0-a46c05f7d11e
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final postId = 'postId';
  final parentCommentId = 'commentId';

  setUpAll(() async {
    registerFallbackValue(GetCommentRequest(referenceId: postId, referenceType: AmityCommentReferenceType.POST.value));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });

  test(
      'When the user query comments with filter by parent id and parent id, it should return list of reply comments under that id.',
      () async {
    when(() => mockCommentApiInterface.queryComment(any<GetCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_get_with_parent_id_success.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComments = await AmitySocialClient.newCommentRepository()
        .getComments()
        .post(postId)
        .parentId(parentCommentId)
        .getPagingData();

    expect(amityComments, isA<PageListData<List<AmityComment>, String>>());
    expect(amityComments.data.first.parentId, parentCommentId);
  });
}
