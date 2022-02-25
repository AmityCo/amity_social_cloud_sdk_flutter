import 'package:amity_sdk/data/data_source/data_source.dart';
import 'package:amity_sdk/domain/repo/file_repo.dart';

class FileRepoImpl extends FileRepo {
  final FileDbAdapter fileDbAdapter;

  FileRepoImpl({required this.fileDbAdapter});
  @override
  Future<String> getFileByIdFromDb(String fileId) {
    return Future.value(fileDbAdapter.getFileEntity(fileId).fileUrl);
  }
}
