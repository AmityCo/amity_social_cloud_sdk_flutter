import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';

class AmityUserFollowInfo {
  String? id;
  AmityFollowStatus status = AmityFollowStatus.NONE;
  int? followingCount = 0;
  int? followerCount = 0;

  Stream<AmityUserFollowInfo> get listen {
    final controller = StreamController<AmityUserFollowInfo>();

    serviceLocator<FollowInfoDbAdapter>().stream(id!).listen((event) {
      final amityUserFollowInfo = event.convertToAmityUserFollowInfo();
      controller.add(amityUserFollowInfo);
    });

    return controller.stream;
  }
}
