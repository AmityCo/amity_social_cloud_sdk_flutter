// To parse this JSON data, do
//
//     final createCommentRequest = createCommentRequestFromJson(jsonString);

import 'dart:convert';

import 'package:amity_sdk/src/domain/domain.dart';

CreateCommentRequest createCommentRequestFromJson(String str) =>
    CreateCommentRequest.fromJson(json.decode(str));

String createCommentRequestToJson(CreateCommentRequest data) =>
    json.encode(data.toJson());

class CreateCommentRequest {
  CreateCommentRequest({
    required this.referenceId,
    required this.referenceType,
    this.data,
    this.metadata,
    this.commentId,
    this.parentId,
    this.mentionees,
  });

  final String referenceId;
  final String referenceType;
  CreateCommentData? data;
  Map<String, dynamic>? metadata;
  String? commentId;
  String? parentId;

  /// Mentionees
  List<AmityMentioneeTarget>? mentionees;

  factory CreateCommentRequest.fromJson(Map<String, dynamic> json) =>
      CreateCommentRequest(
        referenceId: json["referenceId"],
        referenceType: json["referenceType"],
        data: CreateCommentData.fromJson(json["data"]),
        metadata: json["metadata"],
        commentId: json["commentId"],
        parentId: json["parentId"],
      );

  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "referenceType": referenceType,
        "data": data!.toJson(),
        "metadata": metadata,
        "commentId": commentId,
        "parentId": parentId,
        "mentionees": mentionees == null
            ? null
            : List<dynamic>.from(mentionees!.map((x) => x.toJson())),
      }..removeWhere((key, value) => value == null);

  @override
  String toString() =>
      'CreateCommentRequest(referenceId: $referenceId, referenceType: $referenceType)';
}

class CreateCommentData {
  CreateCommentData({
    this.text,
  });

  String? text;

  factory CreateCommentData.fromJson(Map<String, dynamic> json) =>
      CreateCommentData(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      }..removeWhere((key, value) => value == null);
}
