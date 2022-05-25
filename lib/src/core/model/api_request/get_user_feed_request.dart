// To parse this JSON data, do
//
//     final userFeedRequest = userFeedRequestFromJson(jsonString);

// ignore_for_file: hash_and_equals

import 'core/option_request.dart';

class GetUserFeedRequest {
  GetUserFeedRequest({
    required this.userId,
    this.sortBy,
    this.isDeleted,
    this.hasFlag,
    this.options,
    this.dataTypes,
  });

  final String userId;
  String? sortBy;
  bool? isDeleted;
  bool? hasFlag;
  OptionsRequest? options;
  List<String>? dataTypes;

  factory GetUserFeedRequest.fromJson(Map<String, dynamic> json) =>
      GetUserFeedRequest(
        userId: json["userId"],
        sortBy: json["sortBy"],
        isDeleted: json["isDeleted"],
        hasFlag: json["hasFlag"],
        options: json["options"] == null
            ? null
            : OptionsRequest.fromJson(json["options"]),
        dataTypes: List<String>.from(json["dataTypes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "sortBy": sortBy,
        "isDeleted": isDeleted,
        "hasFlag": hasFlag,
        "options": options?.toJson(),
        "dataTypes": dataTypes?.join(','),
      }..removeWhere((key, value) => value == null);

  @override
  int get hashCode =>
      'USER_FEED_$userId _$sortBy _$isDeleted _${dataTypes?.join(',')}'
          .hashCode;
}
