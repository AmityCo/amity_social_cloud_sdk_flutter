import 'package:amity_sdk/src/public/query_builder/post/post_editor.dart';

class AmityTextPostEditor extends PostEditor {
  AmityTextPostEditor(
      {required String postId,
      required String? text,
      required Map<String, dynamic>? metadata})
      : super(postId: postId, text: text, metadata: metadata);
}

class AmityTextPostEditorBuilder extends PostEditorBuilder {
  AmityTextPostEditorBuilder({required this.postId});
  final String postId;

  String? _text;
  Map<String, dynamic>? _metadata;

  @override
  AmityTextPostEditor build() {
    return AmityTextPostEditor(
        postId: postId, text: _text, metadata: _metadata);
  }

  @override
  PostEditorBuilder metadata(Map<String, dynamic> metadata) {
    _metadata = metadata;
    return this;
  }

  @override
  PostEditorBuilder text(String text) {
    _text = text;
    return this;
  }
}
