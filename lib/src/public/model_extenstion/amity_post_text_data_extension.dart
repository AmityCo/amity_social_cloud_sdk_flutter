import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/query_builder/post/post_text_editor.dart';

extension AmityPostTextDataExtension on TextData {
  AmityTextPostEditorBuilder edit() {
    return AmityTextPostEditorBuilder(postId: postId);
  }
}
