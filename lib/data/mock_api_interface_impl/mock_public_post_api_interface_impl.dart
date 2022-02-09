import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/data/data.dart';

class MockPublicPostApiInterfaceImpl extends PublicPostApiInterface {
  @override
  Future<GetPostByIdResponse> getPostById(String postId) async {
    final data = await JsonUtils.readJsonFromAssets(
        'packages/amity_sdk/assets/test_json/get_post_by_id.json');
    return GetPostByIdResponse.fromJson(data);
  }
}
