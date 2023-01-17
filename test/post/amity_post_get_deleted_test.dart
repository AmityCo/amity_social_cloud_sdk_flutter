import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockPublicPostApiInterface extends Mock
    implements PublicPostApiInterface {}

// integration_test_id:a6ba440c-0585-4788-ac07-5747c505623d
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
      'When the user gets a deleted post, it should return an item not found error  (400400).',
      () async {
    when(() => mockPublicPostApiInterface.getPostById(deletedPostId))
        .thenThrow(AmityException(message: 'PostId Not Found', code: 400400));

    try {
      await AmitySocialClient.newPostRepository().getPost(deletedPostId);
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400400);
    }
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
