import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:2a4926a0-a452-48a9-9e97-6c5dc52ba1a2
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommentApiInterface = MockCommentApiInterface();

  final commentId = '64588aecb7720e7875bcabbe';

  setUpAll(() async {
    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommentApiInterface>(
      () => mockCommentApiInterface,
    );
  });

  test('When user flag comment, it should return valid comment.', () async {
    when(() => mockCommentApiInterface.getComment(commentId))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_comment_get_success.json')
              .readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    when(() => mockCommentApiInterface.flagComment(commentId))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_comment_get_success.json')
              .readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    final amityComment = await AmitySocialClient.newCommentRepository()
        .getComment(commentId: commentId);

    final isflagged = await amityComment.report().flag();

    expect(isflagged, true);
  });
}
