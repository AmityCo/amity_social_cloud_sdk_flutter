import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/public/query_builder/post/post_text_editor.dart';

/// Amity Post Text Data Extension
extension AmityPostTextDataExtension on TextData {
  /// Edit Extension Method
  AmityTextPostEditorBuilder edit() {
    return AmityTextPostEditorBuilder(
        targetId: postId, useCase: serviceLocator());
  }
}
