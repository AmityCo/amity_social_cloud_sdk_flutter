import 'package:amity_sdk/core/enum/amity_mention_type.dart';

abstract class AmityMentionMetadata {
  Map<String, dynamic> toMap();
}

class AmityChannelMentionMetadata extends AmityMentionMetadata {
  final String _mentionType = AmityMentionType.CHANNEL.value;
  final int _index;
  final int _length;
  AmityChannelMentionMetadata(this._index, this._length);

  String get getType => _mentionType;
  int get getIndex => _index;
  int get getLength => _length;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': _mentionType,
      'index': _index,
      'length': _length,
    };
  }
}

class AmityUserMentionMetadata extends AmityMentionMetadata {
  final String _mentionType = AmityMentionType.CHANNEL.value;
  final String _userId;
  final int _index;
  final int _length;
  AmityUserMentionMetadata(this._userId, this._index, this._length);

  String get getType => _mentionType;
  String get getUserId => _userId;
  int get getIndex => _index;
  int get getLength => _length;

  @override
  Map<String, dynamic> toMap() {
    return {
      'userId': _userId,
      'type': _mentionType,
      'index': _index,
      'length': _length,
    };
  }
}
