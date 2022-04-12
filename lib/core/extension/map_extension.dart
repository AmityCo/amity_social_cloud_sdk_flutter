import 'dart:convert';

extension MapExtension on Map {
  String toJson() => jsonEncode(this);
}
