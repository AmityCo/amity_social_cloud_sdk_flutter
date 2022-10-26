/// AmityReactionMap
class AmityReactionMap {
  /// Reaction map
  Map<String, int>? reactions;

  /// init [AmityReactionMap]
  AmityReactionMap({this.reactions});

  /// get reaction count
  int getCount(String reaction) => reactions?[reaction] ?? 0;

  @override
  String toString() => 'AmityReactionMap(reactions: $reactions)';
}
