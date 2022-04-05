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
  Map<String, String>? videoFileId;
  String? streamId;

  factory PostDataResponse.fromJson(Map<String, dynamic> json) =>
      PostDataResponse(
        text: json["text"],
        fileId: json["fileId"],
        thumbnailFileId: json["thumbnailFileId"],
        videoFileId: json["videoFileId"] == null
            ? null
            : Map<String, String>.from(json["videoFileId"]),
        streamId: json["streamId"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "fileId": fileId,
        "thumbnailFileId": thumbnailFileId,
        "videoFileId": videoFileId,
        "streamId": streamId,
      };
}
