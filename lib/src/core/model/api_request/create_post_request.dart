// To parse this JSON data, do
//
//     final createPostRequest = createPostRequestFromJson(jsonString);

class CreatePostRequest {
  CreatePostRequest({
    this.data,
    this.attachments,
    this.dataType,
    required this.targetType,
    required this.targetId,
    this.metadata,
    this.postId,
  });

  CreatePostData? data;
  List<Attachment>? attachments;
  String? dataType;
  final String targetType;
  final String targetId;
  Map<String, dynamic>? metadata;
  String? postId;

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) =>
      CreatePostRequest(
        data: CreatePostData.fromJson(json["data"]),
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
        dataType: json["dataType"],
        targetType: json["targetType"],
        targetId: json["targetId"],
        metadata: json["metadata"],
        postId: json["postId"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "attachments": attachments == null
            ? null
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "dataType": dataType,
        "targetType": targetType,
        "targetId": targetId,
        "metadata": metadata,
        "postId": postId,
      }..removeWhere((key, value) => value == null);

  @override
  String toString() {
    return toJson().toString();
  }
}

class Attachment {
  Attachment({
    this.fileId,
    this.videoFileId,
    required this.type,
  });

  final String? fileId;
  final String? videoFileId;
  final String type;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        fileId: json["fileId"],
        videoFileId: json["videoFileId"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "videoFileId": videoFileId,
        "type": type,
      }..removeWhere((key, value) => value == null);
}

class CreatePostData {
  CreatePostData({
    this.text,
    this.streamId,
    this.pollId,
  });

  String? text;
  String? streamId;
  String? pollId;

  factory CreatePostData.fromJson(Map<String, dynamic> json) => CreatePostData(
        text: json["text"],
        streamId: json["streamId"],
        pollId: json["pollId"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "streamId": streamId,
        "pollId": pollId,
      }..removeWhere((key, value) => value == null);
}
