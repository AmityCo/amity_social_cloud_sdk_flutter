import 'package:amity_sdk/src/domain/model/amity_post/amity_mention_metadata.dart';

class AmityMentionMetadataGetter {
  final Map<String, dynamic> metadata;
  AmityMentionMetadataGetter({required this.metadata});

  List<AmityUserMentionMetadata> getMentionedUsers() {
    List mentionMetadata = metadata['mentioned'];
    return mentionMetadata
        .where((element) => element['type'] == 'user')
        .map<AmityUserMentionMetadata>(
          (element) => AmityUserMentionMetadata(
            userId: element['userId'],
            index: element['index'],
            length: element['length'],
          ),
        )
        .toList();
  }

  List<AmityChannelMentionMetadata> getMentionedChannels() {
    List mentionMetadata = metadata['mentioned'];
    return mentionMetadata
        .where((element) => element['type'] == 'channel')
        .map<AmityChannelMentionMetadata>(
          (element) => AmityChannelMentionMetadata(
            index: element['index'],
            length: element['length'],
          ),
        )
        .toList();
  }
}
