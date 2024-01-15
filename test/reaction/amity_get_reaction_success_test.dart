import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockReactionApiInterface extends Mock implements ReactionApiInterface {}

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:14810bd3-9546-4586-978e-5ceb9ca23a85
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String referenceId = "6582e7eeb786f6e418c1754e";
  String referenceType = 'post';

  final reactionApiInterface = MockReactionApiInterface();

  final userApiInterface = MockUserApiInterface();

  setUpAll(() async {
    registerFallbackValue(GetReactionRequest(
        referenceId: referenceId, referenceType: referenceType));

    registerFallbackValue(UsersRequest());

    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<ReactionApiInterface>(
      () => reactionApiInterface,
    );
    serviceLocator.registerLazySingleton<UserApiInterface>(
      () => userApiInterface,
    );
  });

  test(
      'When user try to query reactions from the existing post, comment, or message that has reactions, it should respond reactions.',
      () async {
    when(() => reactionApiInterface.getReaction(any<GetReactionRequest>()))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_reaction_query_success.json')
              .readAsString();
      return GetReactionResponse.fromJson(jsonDecode(response));
    });

    when(() => userApiInterface.getUserById(any())).thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_user_get_users.json').readAsString();
      return UsersResponse.fromJson(json.decode(response));
    });

    final response = await AmitySocialClient.newPostRepository()
        .getReaction(postId: referenceId)
        .getPagingData();

    expect(response, isA<PageListData<List<AmityReaction>, String>>());
    expect(response.data, isNotEmpty);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
