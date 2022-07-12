/// Poll Post BE Response
class PollResponse {
  /// Init Poll Response
  PollResponse({
    required this.pollId,
    required this.userId,
    required this.question,
    required this.answers,
    required this.answerType,
    required this.closedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isVoted,
    required this.status,
    required this.closedIn,
  });

  /// Poll id
  final String pollId;

  /// User Id
  final String userId;

  /// Questions
  final String question;

  /// Answer for the Post question
  final List<PollAnswer> answers;

  /// Answer type for poll
  final String answerType;

  /// Close time for the poll
  final DateTime? closedAt;

  /// Create At
  final DateTime? createdAt;

  /// Updated At
  final DateTime? updatedAt;

  /// Flag if user voted for the poll
  final bool isVoted;

  /// Poll Status
  final String status;

  /// Closed in
  final int closedIn;

  /// Factory method to generate the poll response from json
  factory PollResponse.fromJson(Map<String, dynamic> json) => PollResponse(
        pollId: json["pollId"],
        userId: json["userId"],
        question: json["question"],
        answers: List<PollAnswer>.from(
            json["answers"].map((x) => PollAnswer.fromJson(x))),
        answerType: json["answerType"],
        closedAt:
            json["closedAt"] == null ? null : DateTime.parse(json["closedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        isVoted: json["isVoted"],
        status: json["status"],
        closedIn: json["closedIn"],
      );

  /// Convert the Poll response to json
  Map<String, dynamic> toJson() => {
        "pollId": pollId,
        "userId": userId,
        "question": question,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "answerType": answerType,
        "closedAt": closedAt,
        "createdAt": createdAt,
        "isVoted": isVoted,
        "status": status,
        "closedIn": closedIn,
      };
}

/// Post Poll Answer
class PollAnswer {
  /// Init Poll Answer
  PollAnswer({
    required this.dataType,
    required this.data,
    required this.voteCount,
    required this.isVotedByUser,
    required this.id,
  });

  /// Answer Data type
  final String dataType;

  /// Answer
  final String data;

  /// Vote Count
  final int voteCount;

  /// Flag is this answer voted by user
  final bool isVotedByUser;

  /// Answer Id
  final String id;

  /// Factory method to generate Poll Answer from json
  factory PollAnswer.fromJson(Map<String, dynamic> json) => PollAnswer(
        dataType: json["dataType"],
        data: json["data"],
        voteCount: json["voteCount"],
        isVotedByUser: json["isVotedByUser"],
        id: json["id"],
      );

  /// Convert Poll Answer to json
  Map<String, dynamic> toJson() => {
        "dataType": dataType,
        "data": data,
        "voteCount": voteCount,
        "isVotedByUser": isVotedByUser,
        "id": id,
      };
}
