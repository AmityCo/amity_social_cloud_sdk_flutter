import 'dart:convert';

/// Map Extension method
extension MapExtension on Map {
  /// Convert Map to Json String
  String toJson() => jsonEncode(this);

  /// Remove all the null value from Map
  void removeNullValue() {
    removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));
  }
}
