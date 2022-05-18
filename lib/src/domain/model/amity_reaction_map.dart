class AmityReactionMap {
  Map<String, int>? reactions;
  AmityReactionMap({this.reactions});
  int getCount(String reaction) => reactions?[reaction] ?? 0;

  @override
  String toString() => 'AmityReactionMap(reactions: $reactions)';
}
