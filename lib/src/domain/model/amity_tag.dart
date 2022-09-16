import 'dart:convert';

/// AmityTags
class AmityTags {
  List<String>? tags = [];

  /// Init [AmityTags]
  AmityTags({
    this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'tags': tags,
    };
  }

  String toJson() => json.encode(toMap());
}
