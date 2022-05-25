import 'package:amity_sdk/amity_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Community CRUD Test', () {
    CommunityRepository? communityRepository;
    setUp(() async {
      await AmityCoreClient.setup(
          option: AmityCoreClientOption(
              apiKey: 'apiKey',
              httpEndpoint: AmityRegionalHttpEndpoint.STAGING),
          sycInitialization: true);
      await AmityCoreClient.login('victimAndroid').submit();
      communityRepository = AmitySocialClient.newCommunityRepository();
    });
    tearDown(() async {
      communityRepository = null;
      await AmityCoreClient.logout();
    });
    test('Create Community Test', () async {
      final data = await communityRepository!
          .createCommunity('Flutter Unit Test Community')
          .description('Flutter Unit Test Community Description')
          .isPublic(true)
          .create();
      expect(data, const TypeMatcher<AmityCommunity>());
    });
  });
}
