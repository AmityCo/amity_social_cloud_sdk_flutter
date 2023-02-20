import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockPublicPostApiInterface extends Mock
    implements PublicPostApiInterface {}

// integration_test_id:92d452fe-7a28-4441-abfb-6c94f184a8fd
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String postId = 'postId';

  final mockPublicPostApiInterface = MockPublicPostApiInterface();

  setUpAll(() async {
    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<PublicPostApiInterface>(
      () => mockPublicPostApiInterface,
    );
  });

  test(
      'When the user gets a valid post, it should return a valid post. (Video Post)',
      () async {
    when(() => mockPublicPostApiInterface.getPostById(postId))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_post_video.json').readAsString();
      return CreatePostResponse.fromJson(json.decode(response));
    });

    final amityPost =
        await AmitySocialClient.newPostRepository().getPost(postId);

    expect(amityPost, isA<AmityPost>());
    expect(amityPost.data, isA<VideoData>());
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
