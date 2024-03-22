import 'package:amity_sdk/src/core/core.dart';

class GetStoriesByTragetRequest {
  String? targetId;
  String? targetType;
  StoryOptionRequest? options;
  Map<String, String>? targets;

  GetStoriesByTragetRequest({this.targetId, this.targetType, this.options, this.targets});

  factory GetStoriesByTragetRequest.fromJson(Map<String, dynamic> json) {
    return GetStoriesByTragetRequest(
        targetId: json['targetId'],
        targetType: json['targetType'],
        targets: json['targets'],
        options: StoryOptionRequest.fromJson(json['options']));
  }

  Map<String, dynamic> toJson() {
    return {
      'targetId': targetId,
      'targetType': targetType,
      'options': options!.toJson(),
      'targets': targets,
    }..removeNullValue();
  }
}

class StoryOptionRequest {
  String? sortBy;
  String? orderBy;

  StoryOptionRequest({required this.sortBy, required this.orderBy});

  factory StoryOptionRequest.fromJson(Map<String, dynamic> json) {
    return StoryOptionRequest(
        sortBy: json['sortBy'], orderBy: json['orderBy']);
  }

  Map<String, dynamic> toJson() {
    return {'sortBy': sortBy, 'orderBy': orderBy}..removeNullValue();
  }
}
