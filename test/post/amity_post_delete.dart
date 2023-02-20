import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockPublicPostApiInterface extends Mock
    implements PublicPostApiInterface {}

// integration_test_id:5a9f10c2-92d6-4d14-8a86-6bdc659bc62d
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

  test('When the user deletes a valid post, it should return successful result',
      () async {
    when(() => mockPublicPostApiInterface.deletePostById(postId))
        .thenAnswer((_) async {
      return true;
    });

    final success =
        await AmitySocialClient.newPostRepository().deletePost(postId: postId);

    expect(success, true);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
