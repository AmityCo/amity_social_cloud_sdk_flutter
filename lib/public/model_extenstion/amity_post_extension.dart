import 'package:amity_sdk/core/core.dart';
import 'package:amity_sdk/core/enum/reaction_reference_type.dart';
import 'package:amity_sdk/domain/domain.dart';
import 'package:amity_sdk/public/query_builder/reaction/add_reaction_query_builder.dart';

extension AmityPostExtension on AmityPost {
  AddReactionQueryBuilder react() {
    return AddReactionQueryBuilder(
        addReactionUsecase: serviceLocator(),
        removeReactionUsecase: serviceLocator(),
        referenceType: ReactionReferenceType.POST.value,
        referenceId: postId!);
  }
}
