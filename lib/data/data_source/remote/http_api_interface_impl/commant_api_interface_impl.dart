import 'package:amity_sdk/data/data.dart';
import 'package:amity_sdk/data/data_source/remote/api_interface/commnet_api_interface.dart';

class CommentApiInterfaceImpl extends CommentApiInterface {
  final HttpApiClient httpApiClient;

  CommentApiInterfaceImpl({required this.httpApiClient});
}
