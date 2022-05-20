import 'dart:convert';

class AmityTags {
  List<String>? tags;

  Map<String, dynamic> toMap() {
    return {
      'tags': tags,
    };
  }

  String toJson() => json.encode(toMap());
}
