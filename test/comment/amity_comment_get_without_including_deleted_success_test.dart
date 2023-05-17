import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:03056892-251f-4a85-a9bf-f9978c1912e5
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

  test('When the user query comments without including deleted comments, it should return non deleted commets.',
      () async {
    when(() => mockCommentApiInterface.queryComment(any<GetCommentRequest>())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_comment_get_without_including_deleted_success.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComments =
        await AmitySocialClient.newCommentRepository().getComments().post(postId).includeDeleted(false).getPagingData();

    expect(amityComments, isA<PageListData<List<AmityComment>, String>>());
    expect(amityComments.data.firstWhereOrNull((element) => (element.isDeleted ?? false)), isNull);
  });
}
