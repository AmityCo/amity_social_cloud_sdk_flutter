import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/domain/domain.dart';

extension PostResponseExtension on PostResponse {
  AmityPost convertToAmityPost() {
    return AmityPost()..id = postId;
  }

  PostHiveEntity convertToPostHiveEntity() {
    return PostHiveEntity()..id = postId;
  }
}

// postResponse.convertToPostHiveEntity();
