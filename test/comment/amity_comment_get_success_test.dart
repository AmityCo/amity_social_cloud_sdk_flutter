import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:0be48975-be6d-4199-bec0-af186af444d3
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final postId = 'postId';

  setUpAll(() async {
    registerFallbackValue(GetCommentRequest(referenceId: postId, referenceType: AmityCommentReferenceType.POST.value));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });

  test('When the user query comments, it should return valid comments.', () async {
    when(() => mockCommentApiInterface.queryComment(any<GetCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_get_success.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComments = await AmitySocialClient.newCommentRepository().getComments().post(postId).getPagingData();

    expect(amityComments, isA<PageListData<List<AmityComment>, String>>());
  });
}
