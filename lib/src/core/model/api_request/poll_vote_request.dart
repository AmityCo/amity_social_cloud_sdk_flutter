/// Class PollVoteRequest
class PollVoteRequest {
  /// Init PollVoteRequest
  PollVoteRequest({
    required this.text,
    required this.pollId,
    required this.answerIds,
  });

  /// Text
  final String text;

  /// Poll Id
  final String pollId;

  /// Answer
  final List<String> answerIds;

  /// factory method to create [PollVoteRequest] from json
  factory PollVoteRequest.fromJson(Map<String, dynamic> json) =>
      PollVoteRequest(
        text: json["text"],
        pollId: json["pollId"],
        answerIds: List<String>.from(json["answerIds"].map((x) => x)),
      );

  /// Convert [PollVoteRequest] to Map
  Map<String, dynamic> toJson() => {
        "text": text,
        "pollId": pollId,
        "answerIds": List<dynamic>.from(answerIds.map((x) => x)),
      };
}
