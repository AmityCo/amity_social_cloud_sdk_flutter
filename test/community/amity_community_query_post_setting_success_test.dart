import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockCommunityApiInterface extends Mock implements CommunityApiInterface {}

// integration_test_id:27a42d3a-2444-4a77-9eb9-36895c7be1ea
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockCommunityApiInterface = MockCommunityApiInterface();

  setUpAll(() async {
    registerFallbackValue(CreateCommunityRequest());

    await AmityCoreClientMockSetup.setup();

    serviceLocator.registerLazySingleton<CommunityApiInterface>(
      () => mockCommunityApiInterface,
    );

    registerFallbackValue(GetCommunityRequest());
  });

  test('When the user query valid communities, it should return a communities with valid `postSetting`.', () async {
    when(() => mockCommunityApiInterface.getCommunityQuery(any())).thenAnswer((_) async {
      final response = await File('test/mock_json/amity_community_query_success.json').readAsString();
      return CreateCommunityResponse.fromJson(json.decode(response));
    });

    final amityCommunity = await AmitySocialClient.newCommunityRepository().getCommunities().getPagingData();

    expect(amityCommunity, isA<PageListData<List<AmityCommunity>, String>>());
    expect(amityCommunity.data, isA<List<AmityCommunity>>());
  });
}
