import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockPublicPostApiInterface extends Mock
    implements PublicPostApiInterface {}

// integration_test_id:2a7624b9-560f-45d7-a2ae-6427315a1cea
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String deletedPostId = 'deletePostId';

  final mockPublicPostApiInterface = MockPublicPostApiInterface();

  setUpAll(() async {
    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<PublicPostApiInterface>(
      () => mockPublicPostApiInterface,
    );
  });

  test(
      'When the user deletes an invalid post that doesn\'t exist, it should return a not found error (400400).',
      () async {
    when(() => mockPublicPostApiInterface.deletePostById(deletedPostId))
        .thenThrow(AmityException(message: 'PostId Not Found', code: 400400));

    try {
      await AmitySocialClient.newPostRepository()
          .deletePost(postId: deletedPostId);
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400400);
    }
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
