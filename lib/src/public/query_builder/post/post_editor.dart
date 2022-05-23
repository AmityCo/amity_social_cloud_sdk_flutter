import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/usecase/usecase.dart';

abstract class PostEditor {
  final String postId;
  final String? text;
  final Map<String, dynamic>? metadata;

  PostEditor({required this.postId, required this.text, required this.metadata});

  Future update() {
    UpdatePostRequest updatePostRequest = UpdatePostRequest(postId: postId);
    UpdatePostData updateData = UpdatePostData();
    if (text != null) updateData.text = text;
    updatePostRequest.data = updateData;
    updatePostRequest.metadata = metadata;
    return serviceLocator<PostUpdateUsecase>().get(updatePostRequest);
  }
}

abstract class PostEditorBuilder {
  PostEditorBuilder text(String text);
  PostEditorBuilder metadata(Map<String, dynamic> metadata);
  PostEditor build();
}
