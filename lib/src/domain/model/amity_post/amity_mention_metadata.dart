import 'package:amity_sdk/src/core/enum/amity_mention_type.dart';

abstract class AmityMentionMetadata {
  Map<String, dynamic> toMap();
}

class AmityChannelMentionMetadata extends AmityMentionMetadata {
  final String _mentionType = AmityMentionType.CHANNEL.value;
  final int index;
  final int length;
  AmityChannelMentionMetadata({required this.index, required this.length});

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': _mentionType,
      'index': index,
      'length': length,
    };
  }
}

class AmityUserMentionMetadata extends AmityMentionMetadata {
  final String _mentionType = AmityMentionType.USER.value;
  final String userId;
  final int index;
  final int length;
  AmityUserMentionMetadata(
      {required this.userId, required this.index, required this.length});

  @override
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': _mentionType,
      'index': index,
      'length': length,
    };
  }
}
