import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [GetFileUserCase]
class GetFileUserCase extends UseCase<AmityFileProperties, String> {
  /// File Repo
  final FileRepo fileRepo;

  /// init [GetFileUserCase]
  GetFileUserCase(this.fileRepo);
  @override
  Future<AmityFileProperties> get(String params) {
    return fileRepo.getFileByIdFromDb(params);
  }
}
