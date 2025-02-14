enum AmityNonce {
  UNKNOWN,
  CHANNEL_LIST,
  COMMUNITY_LIST,
  PINNED_POST_LIST,
  GLOBAL_PINNED_POST_LIST,
  POST_LIST,
  GLOBAL_FEED,
  CUSTOM_RANKING_FEED,
  MESSAGE_LIST,
  USER_LIST,
  COMMENT_LIST,
  REACTION_LIST,
  COMMUNITY_MEMBER_LIST,
  FOLLOWING_LIST,
  FOLLOWER_LIST,
}

extension AmityNonceExtension on AmityNonce {
  int get value {
    final nonce = AmityNonce.values[index];
    switch (nonce) {
      case AmityNonce.CHANNEL_LIST:
        return 1;
      case AmityNonce.COMMUNITY_LIST:
        return 2;
      case AmityNonce.PINNED_POST_LIST:
        return 3;
      case AmityNonce.POST_LIST:
        return 4;
      case AmityNonce.GLOBAL_FEED:
        return 5;
      case AmityNonce.CUSTOM_RANKING_FEED:
        return 6;
      case AmityNonce.MESSAGE_LIST:
        return 7;
      case AmityNonce.USER_LIST:
        return 8;
      case AmityNonce.GLOBAL_PINNED_POST_LIST:
        return 9;
      case AmityNonce.COMMENT_LIST:
        return 10;
      case AmityNonce.REACTION_LIST:
        return 11;
      case AmityNonce.COMMUNITY_MEMBER_LIST:
        return 12;
      case AmityNonce.FOLLOWING_LIST:
        return 13;
      case AmityNonce.FOLLOWER_LIST:
        return 14;
      default:
        return 0;
    }
  }

  static AmityNonce enumOf(int value) {
    return AmityNonce.values.firstWhere(
      (element) => element.value == value,
      orElse: () => AmityNonce.UNKNOWN,
    );
  }
}
