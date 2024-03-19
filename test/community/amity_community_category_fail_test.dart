import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityCategoryApiInterface {}

// integration_test_id:94ad40ba-b1f0-4b6b-9118-2f481d17a14a
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommunityCategoryApiInterface = MockCommunityApiInterface();

  setUpAll(() async {
    registerFallbackValue(String);

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommunityCategoryApiInterface>(
      () => mockCommunityCategoryApiInterface,
    );
  });

  test('When the user get categories that do not exist, It should return a not found error (400400: CategoryId Not Found).', () async {
    when(() => mockCommunityCategoryApiInterface.getCommunityCategory(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_query_catergoies_fail.json').readAsString();
      throw AmityErrorResponse.fromJson(json.decode(response)).amityException();
    });

    try {
    final amityCommunityCategory = await AmitySocialClient.newCommunityRepository().getCategory("invalidCategoryId");
    } catch (error) {
      expect(error, isA<AmityException>());
      expect((error as AmityException).code, 400400);
    }
    
  });
}
