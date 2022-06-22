import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';

class AmityMyFollowInfo {
  String? id;
  int? followingCount = 0;
  int? followerCount = 0;
  int? pendingRequestCount = 0;

  Stream<AmityMyFollowInfo> get listen {
    final controller = StreamController<AmityMyFollowInfo>();

    serviceLocator<FollowInfoDbAdapter>().stream(id!).listen((event) {
      final amityUserFollowInfo = event.convertToAmityMyFollowInfo();
      controller.add(amityUserFollowInfo);
    });

    return controller.stream;
  }
}
