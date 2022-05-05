import 'package:amity_sdk/src/domain/model/amity_post/amity_mention_metadata.dart';

class AmityMentionMetadataCreator {
  final List<AmityMentionMetadata> _mentionMetaData;

  AmityMentionMetadataCreator(this._mentionMetaData);

  Map<String, dynamic> create() {
    return {'mentioned': _mentionMetaData.map((e) => e.toMap).toList()};
  }
}
