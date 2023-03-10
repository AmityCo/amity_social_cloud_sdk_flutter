import 'dart:convert';
import 'dart:io';

import 'package:amity_sdk/src/src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../helper/amity_core_client_mock_setup.dart';

class MockReactionApiInterface extends Mock implements ReactionApiInterface {}

class MockUserApiInterface extends Mock implements UserApiInterface {}

// integration_test_id:f4507f50-d426-44ff-9c0f-ed7c8f1c0f57
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String referenceId = const Uuid().v1();
  String referenceType = 'post';

  final reactionApiInterface = MockReactionApiInterface();

  setUpAll(() async {
    registerFallbackValue(GetReactionRequest(
        referenceId: referenceId, referenceType: referenceType));

    registerFallbackValue(UsersRequest());

    await AmityCoreClientMockSetup.setup();
    await AmityCoreClientMockSetup.loadMockSession();

    serviceLocator.registerLazySingleton<ReactionApiInterface>(
      () => reactionApiInterface,
    );
  });

  test(
      'When user query reactions from the post, comment or meesage that does not have any reaction, it should respond empty.',
      () async {
    when(() => reactionApiInterface.getReaction(any<GetReactionRequest>()))
        .thenAnswer((_) async {
      final response =
          await File('test/mock_json/amity_reaction_query_empty_success.json')
              .readAsString();
      return GetReactionResponse.fromJson(jsonDecode(response));
    });

    final response = await AmitySocialClient.newPostRepository()
        .getReaction(postId: referenceId)
        .getPagingData();

    expect(response, isA<PageListData<List<AmityReaction>, String>>());
    expect(response.data, isEmpty);
  });

  tearDownAll(() async {
    await AmityCoreClient.logout();
  });
}
