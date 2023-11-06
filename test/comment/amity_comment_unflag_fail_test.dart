import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommentApiInterface extends Mock implements CommentApiInterface {}

// integration_test_id:771f0fbb-583e-402d-991c-43a3bb2ac70b
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

  test(
      'When user flag comment that already flagged, it should return not allowed error (400300).',
      () async {
    when(() => mockCommentApiInterface.getComment(commentId))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_comment_get_success.json')
              .readAsString();
      return CreateCommentResponse.fromJson(json.decode(response));
    });

    when(() => mockCommentApiInterface.unflagComment(commentId))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_comment_flag_fail.json')
              .readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    final amityComment = await AmitySocialClient.newCommentRepository()
        .getComment(commentId: commentId);

    try {
      final isflagged = await amityComment.report().unflag();
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400300);
    }
  });
}
