import 'package:amity_sdk/amity_sdk.dart';
  /* begin_sample_code
    gist_id: ba0f1fac4740b6d6ce077fe040ce582d
    filename: AmityCommentTarget.dart
    asc_page: https://docs.amity.co/social/flutter
    description: Flutter flag comment example
    */
  void checkCommentTarget(AmityComment comment) {

    if(comment.target is CommunityCommentTarget){
      AmityCommunityMember user = (comment.target as CommunityCommentTarget).creatorMember!;
      if(user.roles!.contains("moderator") || user.roles!.contains("community-moderator") ){
        // Member is a moderator
      }else{
        // Member is a not a moderator
      }
    }

    if(comment.target is UserCommentTarget){
      String userId = (comment.target as UserCommentTarget).userId!;
      // TODO: Use userid to get user
    }

    if(comment.target is ContentCommentTarget){
      String contentId = (comment.target as ContentCommentTarget).contentId!;
      // TODO: Use content id to get content
    }

    if(comment.target is UnknownCommentTarget){
      // TODO: handle unknown target
    }
    
  }
  /* end_sample_code */
