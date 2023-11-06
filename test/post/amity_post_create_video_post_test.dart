import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockPublicPostApiInterface extends Mock
    implements PublicPostApiInterface {}

// integration_test_id:0c2115ef-9414-4710-aae8-299614e82407
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String postId = 'postId';

  final mockPublicPostApiInterface = MockPublicPostApiInterface();

  List<AmityVideo> video = [];

  String postText = "postText";

  String targetUserId = 'targetUserId';

  setUpAll(() async {
    registerFallbackValue(CreatePostRequest(targetId: '', targetType: ''));

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<PublicPostApiInterface>(
      () => mockPublicPostApiInterface,
    );
  });

  test(
      'When the user gets a valid post, it should return a valid post. (Video Post)',
      () async {
    when(() => mockPublicPostApiInterface.createPost(any<CreatePostRequest>()))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_post_video.json').readAsString();
      return CreatePostResponse.fromJson(json.decode(response));
    });

    final amityPost =
        await AmitySocialClient.newPostRepository().createPost()
            .targetUser(targetUserId)
            .video(video)
            .text(postText)
            .post();

    expect(amityPost, isA<AmityPost>());
    expect(amityPost.data, isA<VideoData>());
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
