import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:4550e036-53d0-4f35-b83f-9edc10f1c974
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

  test(
      'When user query comments with image only dataTypes(exact), it should return collection of comments containing image only',
      () async {
    when(() => mockCommentApiInterface.queryComment(any<GetCommentRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_comment_get_image_excat_success.json').readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComments = await AmitySocialClient.newCommentRepository()
        .getComments()
        .post(postId)
        .dataTypes(AmityCommentDataTypeFilter.exact(dataTypes: [AmityDataType.IMAGE]))
        .getPagingData();

    expect(amityComments, isA<PageListData<List<AmityComment>, String>>());
    expect(amityComments.data.firstWhereOrNull((element) => element.dataTypes!.contains(AmityDataType.TEXT.value)),
        isNull);
  });
}
