import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockPublicPostApiInterface extends Mock
    implements PublicPostApiInterface {}

// integration_test_id:a39d840e-62f7-4b02-b3c4-9daaaa374f06
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
      'When the user gets a valid post, it should return a valid post. (Image Post)',
      () async {
    when(() => mockPublicPostApiInterface.getPostById(postId))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_post_image.json').readAsString();
      return CreatePostResponse.fromJson(json.decode(response));
    });

    final amityPost =
        await AmitySocialClient.newPostRepository().getPost(postId);
    final amityChildPost = amityPost.children;

    expect(amityPost, isA<AmityPost>());
    expect(amityChildPost, isNotNull);
    expect(amityChildPost!.isNotEmpty, isTrue);
    expect(amityChildPost.first.data, isA<ImageData>());
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
