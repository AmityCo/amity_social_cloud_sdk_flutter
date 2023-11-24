import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';
import 'package:amity_sdk/src/domain/model/amity_stream/amity_stream.dart';

class StreamComposerUseCase {
  final UserRepo userRepo;
  final UserComposerUsecase userComposerUsecase;
  StreamComposerUseCase(
      {required this.userRepo, required this.userComposerUsecase});
  Future<AmityStream> get(AmityStream params) async {
    if (params.userId != null) {
      params.user = await userRepo.getUserByIdFromDb(params.userId!);
    }

    return params;
  }
}
