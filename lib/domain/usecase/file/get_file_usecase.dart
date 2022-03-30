import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/domain/model/amity_file/amity_file_properties.dart';

class GetFileUserCase extends UseCase<AmityFileProperties, String> {
  final FileRepo fileRepo;
  GetFileUserCase(this.fileRepo);
  @override
  Future<AmityFileProperties> get(String params) {
    return fileRepo.getFileByIdFromDb(params);
  }

  @override
  Stream<AmityFileProperties> listen(String params) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
