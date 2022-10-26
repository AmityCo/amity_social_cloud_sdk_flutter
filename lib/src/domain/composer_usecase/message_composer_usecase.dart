import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// [MessageComposerUsecase]
class MessageComposerUsecase extends UseCase<AmityMessage, AmityMessage> {
  /// User Repo
  final UserRepo userRepo;

  /// Message Repo
  final MessageRepo messageRepo;

  /// User Composer Usecase
  final UserComposerUsecase userComposerUsecase;

  /// Message File Composer Usecase
  final MessageFileComposerUsecase messageComposerUsecase;

  /// Init [MessageComposerUsecase]
  MessageComposerUsecase({
    required this.userRepo,
    required this.messageRepo,
    required this.userComposerUsecase,
    required this.messageComposerUsecase,
  });
  @override
  Future<AmityMessage> get(AmityMessage params) async {
    //Add File url to DataType != TEXT
    final data = params.data;
    if (data != null && data is! TextData) {
      params.data = await messageComposerUsecase.get(data);
    }

    /// Compose Posted User
    params.user = await userRepo.getUserByIdFromDb(params.userId!);
    params.user = await userComposerUsecase.get(params.user!);

    return params;
  }
}
