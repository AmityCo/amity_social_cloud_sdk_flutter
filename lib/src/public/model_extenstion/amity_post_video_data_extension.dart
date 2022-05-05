import 'package:amity_sdk/src/core/service_locator/service_locator.dart';
import 'package:amity_sdk/src/domain/model/amity_file/amity_file.dart';
import 'package:amity_sdk/src/domain/model/amity_post.dart';
import 'package:amity_sdk/src/domain/usecase/file/get_file_usecase.dart';

extension AmityPostVideoDataExtension on VideoData {
  Future<AmityVideo> getVideo(AmityVideoQuality quality) async {
    String fileId = rawData!.containsKey(quality.value)
        ? rawData![quality.value]
        : rawData![AmityVideoQuality.ORIGINAL.value];
    return AmityVideo(await serviceLocator<GetFileUserCase>().get(fileId));
  }
}
