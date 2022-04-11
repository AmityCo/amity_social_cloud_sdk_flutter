import 'dart:io';

import 'package:amity_sdk/lib.dart';

class AmityPostImageCreation {
  /* begin_sample_code
    gist_id: 53e67894a1e6baa80c99ef4681a50ea4
    filename: AmityPostImageCreation.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter create image post example
    */
  void createImagePost(File uploadingImage) async {
    //first, upload image
    AmityImage? uploadedImage;
    AmityUploadResult<AmityImage> amityUploadResult =
        await AmityCoreClient.newFileRepository().image(uploadingImage).upload();
    //check if the upload result is complete
    if (amityUploadResult is AmityUploadComplete) {
      final amityUploadComplete = amityUploadResult as AmityUploadComplete;
      //cast amityUploadResult to AmityImage and store it in uploadedImage variable
      uploadedImage = amityUploadComplete.getFile as AmityImage;
    }
    //check if the upload result is complete
    else if (amityUploadResult is AmityUploadError) {
      final amityUploadError = amityUploadResult as AmityUploadError;
      final AmityException amityException = amityUploadError.getErrror;
      //handle error
    }

    //then create an image post
    AmitySocialClient.newPostRepository()
        .createPost()
        .targetUser('userId') // or targetMe(), targetCommunity(communityId: String)
        .image([uploadedImage!])
        .text('Hello from flutter with image!')
        .post()
        .then((AmityPost post) => {
              //handle result
            })
        .onError((error, stackTrace) => {
              //handle error
            });
  }
  /* end_sample_code */
}
