import 'dart:async';
import 'dart:convert';

import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/data/data.dart';
import 'package:amity_sdk/src/domain/composer_usecase/community_member_composer_usecase.dart';
import 'package:amity_sdk/src/domain/model/amity_user.dart';

class AmityCommunityMember {
  String? communityId;
  String? userId;
  String? channelId;
  bool? isBanned; //Notify
  List<String>? roles; //Notify
  AmityUser? user; //Compose

  Stream<AmityCommunityMember> get listen {
    StreamController<AmityCommunityMember> controller =
        StreamController<AmityCommunityMember>();

    serviceLocator<CommunityMemberDbAdapter>()
        .listenCommnunityMemberEntity(communityId! + userId!)
        .listen((event) {
      final updateAmityCommunity = event.convertToAmityCommunityMember();

      //TOOD: Good idea would be have compose method inside the object itself
      serviceLocator<CommunityMemberComposerUsecase>()
          .get(updateAmityCommunity)
          .then(
            (value) => controller.add(value),
          );
    });

    return controller.stream;
  }

  Map<String, dynamic> toMap() {
    return {
      'communityId': communityId,
      'userId': userId,
      'channelId': channelId,
      'isBanned': isBanned,
      'roles': roles,
      'user': user?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => toJson();
}
