import 'package:amity_sdk/data/data_source/remote/api_interface/file_api_interface.dart';
import 'package:amity_sdk/data/data_source/remote/client/http/http_api_client.dart';

class FileApiInterfaceImpl extends FileApiInterface {
  final HttpApiClient httpApiClient;

  FileApiInterfaceImpl({required this.httpApiClient});
}
