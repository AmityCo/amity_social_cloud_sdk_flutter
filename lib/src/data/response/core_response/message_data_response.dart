/// Poll Data Response
class MessageDataResponse {
  /// Init Post Data Response
  MessageDataResponse({
    required this.text,
    required this.fileId,
    required this.caption,
  });

  /// Text
  String? text;

  /// File Id
  String? fileId;

  /// Caption
  String? caption;

  /// Factory method to init from json
  factory MessageDataResponse.fromJson(Map<String, dynamic>? json) =>
      MessageDataResponse(
        text: json?["text"],
        fileId: json?["fileId"],
        caption: json?["caption"],
      );

  /// convert to map
  Map<String, dynamic> toJson() => {
        "text": text,
        "fileId": fileId,
        "caption": caption,
      };
}
