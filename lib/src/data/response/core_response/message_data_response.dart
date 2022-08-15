/// Poll Data Response
class MessageDataResponse {
  /// Init Post Data Response
  MessageDataResponse({
    required this.text,
    required this.fileId,
    required this.thumbnailFileId,
    required this.videoFileId,
    required this.streamId,
    required this.pollId,
  });

  /// Text
  String? text;

  /// File Id
  String? fileId;

  /// Thumbnail File Id
  String? thumbnailFileId;

  /// Video File Id
  Map<String, String>? videoFileId;

  /// Stream Id
  String? streamId;

  /// Poll Id
  String? pollId;

  /// Factory method to init from json
  factory MessageDataResponse.fromJson(Map<String, dynamic> json) =>
      MessageDataResponse(
        text: json["text"],
        fileId: json["fileId"],
        thumbnailFileId: json["thumbnailFileId"],
        videoFileId: json["videoFileId"] == null
            ? null
            : Map<String, String>.from(json["videoFileId"]),
        streamId: json["streamId"],
        pollId: json["pollId"],
      );

  /// convert to map
  Map<String, dynamic> toJson() => {
        "text": text,
        "fileId": fileId,
        "thumbnailFileId": thumbnailFileId,
        "videoFileId": videoFileId,
        "streamId": streamId,
        "pollId": pollId,
      };
}
