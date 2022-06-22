import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';

class AmityFollowRelationship {
  String? sourceUserId;
  String? targetUserId;
  AmityUser? sourceUser;
  AmityUser? targetUser;
  AmityFollowStatus? status = AmityFollowStatus.NONE;

  Stream<AmityFollowRelationship> get listen {
    final controller = StreamController<AmityFollowRelationship>();

    serviceLocator<FollowDbAdapter>()
        .stream('${sourceUserId}_$targetUserId')
        .listen((event) {
      final amityFollowRelationship = event.convertToAmityFollowRelationship();
      controller.add(amityFollowRelationship);
    });

    return controller.stream;
  }

  // @override
  // String toString() {
  //   return 'AmityFollowRelationship(sourceUserId: $sourceUserId, targetUserId: $targetUserId, sourceUser: $sourceUser, targetUser: $targetUser, status: $status)';
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'sourceUserId': sourceUserId,
  //     'targetUserId': targetUserId,
  //     'sourceUser': sourceUser?.toMap(),
  //     'targetUser': targetUser?.toMap(),
  //     'status': status?.value,
  //   };
  // }

  // String toJson() => json.encode(toMap());
}
