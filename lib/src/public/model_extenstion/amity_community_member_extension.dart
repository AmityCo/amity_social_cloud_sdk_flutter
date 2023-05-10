import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

extension AmityCommunityMemberExtension on AmityCommunityMember {
  StreamController<AmityCommunityMember> get listen {
    final controller = StreamController<AmityCommunityMember>();

    serviceLocator<CommunityMemberDbAdapter>()
        .listenCommnunityMemberEntity(communityId!)
        .listen((event) {
      final updateAmityCommunityMember = event.convertToAmityCommunityMember();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<CommunityMemberComposerUsecase>()
          .get(updateAmityCommunityMember)
          .then(
            (value) => controller.add(value),
          );
    });

    return controller;
  }
}
