import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:780d5806-8ca5-43f3-8a73-50f6cdaa0e79
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

  test('When the user query comments with filter by parent id but no parent id, it should return all reply comments.',
      () async {
    when(() => mockCommentApiInterface.queryComment(any<GetCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_get_without_parent_id_success.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComments = await AmitySocialClient.newCommentRepository().getComments().post(postId).getPagingData();

    expect(amityComments, isA<PageListData<List<AmityComment>, String>>());
    expect(amityComments.data.firstWhereOrNull((element) => (element.childrenNumber ?? 0) >= 1), isNotNull);
  });
}
