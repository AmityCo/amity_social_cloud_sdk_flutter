class MapObject {
  final Map<String, dynamic> data;
  MapObject({required this.data});

  factory MapObject.fromJson(Map<String, dynamic> json) {
    return MapObject(data: json);
  }

  Map<String, dynamic> toJson() => data;
}
