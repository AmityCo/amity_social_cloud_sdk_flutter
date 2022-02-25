class PostDataResponse {
  PostDataResponse({
    required this.text,
    required this.fileId,
    required this.thumbnailFileId,
    required this.videoFileId,
    required this.streamId,
  });

  String? text;
  String? fileId;
  String? thumbnailFileId;
  VideoFileId? videoFileId;
  String? streamId;

  factory PostDataResponse.fromJson(Map<String, dynamic> json) =>
      PostDataResponse(
        text: json["text"],
        fileId: json["fileId"],
        thumbnailFileId: json["thumbnailFileId"],
        videoFileId: json["videoFileId"] == null
            ? null
            : VideoFileId.fromJson(json["videoFileId"]),
        streamId: json["streamId"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "fileId": fileId,
        "thumbnailFileId": thumbnailFileId,
        "videoFileId": videoFileId == null ? null : videoFileId!.toJson(),
        "streamId": streamId,
      };
}

class VideoFileId {
  VideoFileId({
    required this.original,
    required this.low,
    required this.medium,
    required this.high,
  });

  final String original;
  final String low;
  final String medium;
  final String high;

  factory VideoFileId.fromJson(Map<String, dynamic> json) => VideoFileId(
        original: json["original"],
        low: json["low"],
        medium: json["medium"],
        high: json["high"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "low": low,
        "medium": medium,
        "high": high,
      };
}
