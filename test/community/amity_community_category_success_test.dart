import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityCategoryApiInterface {}

// integration_test_id:55e1b906-69bd-4ccc-a8dc-115290f50b25
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommunityCategoryApiInterface = MockCommunityApiInterface();

  setUpAll(() async {
    registerFallbackValue(GetCommunityCategoryRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommunityCategoryApiInterface>(
      () => mockCommunityCategoryApiInterface,
    );
  });

  test('When the user get valid categories, it should return a valid categories.', () async {
    when(() => mockCommunityCategoryApiInterface.communityCategoryQuery(any<GetCommunityCategoryRequest>())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_query_catergoies_success.json').readAsString();
      return CreateCommunityResponse.fromJson(json.decode(response));
    });

    final amityCommunityCategoriesPage = await AmitySocialClient.newCommunityRepository().getCategories().sortBy(AmityCommunityCategorySortOption.NAME).getPagingData(token: "", limit: 10);
    final amityCommunityCategories = amityCommunityCategoriesPage.data;
    expect(amityCommunityCategories, isList);
  });
}
