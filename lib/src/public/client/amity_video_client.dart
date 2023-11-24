import 'package:amity_sdk/src/public/repo/stream/stream_repository.dart';
import 'package:amity_sdk/src/src.dart';

class AmityVideoClient{
  static StreamRepository newStreamRepository() => serviceLocator<StreamRepository>();
}