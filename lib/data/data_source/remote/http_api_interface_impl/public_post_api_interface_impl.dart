import 'package:amity_sdk/data/data.dart';

class PublicPostApiInterfaceImpl extends PublicPostApiInterface {
  PublicPostApiInterfaceImpl({required this.httpApiClient});
  final HttpApiClient httpApiClient;
  @override
  Future<GetPostByIdResponse> getPostById(String postId) async {
    throw UnimplementedError();
  }
}
