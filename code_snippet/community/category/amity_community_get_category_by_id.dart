import 'package:amity_sdk/amity_sdk.dart';

class AmityGetCategory {
  /* begin_sample_code
    gist_id: 6f52edfcf116564d02dbb15edea95128
    filename: AmityGetCategory.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter get community category by id example
    */
  void getCommunityCategoryById(String categoryId) {
    AmitySocialClient.newCommunityRepository()
        .getCategory(categoryId)
        .then((category) {
          //handle result
        }).onError((error, stackTrace){
          //handle error
        });
  }
  /* end_sample_code */
}
