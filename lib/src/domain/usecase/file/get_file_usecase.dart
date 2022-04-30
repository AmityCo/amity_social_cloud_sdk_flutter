import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

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
