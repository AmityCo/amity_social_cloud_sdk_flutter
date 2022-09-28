import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [AmityFollowRelationshipExtenstion]
extension AmityFollowRelationshipExtenstion on AmityFollowRelationship {
  ///Unfollow the following user
  Future unfollow() {
    return serviceLocator<UnfollowUsecase>().get(targetUserId!);
  }

  ///Remove the user from follower list
  Future removeFollower() {
    return serviceLocator<RemoveFollowerUsecase>().get(sourceUserId!);
  }

  /// Accept the incoming follow request
  Future accept() {
    return serviceLocator<AcceptFollowUsecase>().get(sourceUserId!);
  }

  /// Decline the incoming follow request
  Future decline() {
    return serviceLocator<DeclineFollowUsecase>().get(sourceUserId!);
  }

  /// Listen any changes Amity Follow Relationship
  StreamController<AmityFollowRelationship> get listen {
    final controller = StreamController<AmityFollowRelationship>();

    serviceLocator<FollowDbAdapter>()
        .stream('${sourceUserId}_$targetUserId')
        .listen((event) {
      final amityFollowRelationship = event.convertToAmityFollowRelationship();

      serviceLocator<AmityFollowRelationshipComposerUsecase>()
          .get(amityFollowRelationship)
          .then((value) => controller.add(value));
    });

    return controller;
  }
}
