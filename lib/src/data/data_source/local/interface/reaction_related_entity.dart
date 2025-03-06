abstract interface class ReactionRelatedEntity<T> {
  Map<String, int>? reactions;
  int? reactionsCount;
  List<String>? myReactions;
  T copyEntity();
}