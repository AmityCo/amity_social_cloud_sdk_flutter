class PollResponse {
  PollResponse({
    required this.pollId,
    required this.userId,
    required this.question,
    required this.answers,
    required this.answerType,
    required this.closedAt,
    required this.createdAt,
    required this.isVoted,
    required this.status,
    required this.closedIn,
  });

  final String pollId;
  final String userId;
  final String question;
  final List<Answer> answers;
  final String answerType;
  final String closedAt;
  final String createdAt;
  final bool isVoted;
  final String status;
  final int closedIn;

  factory PollResponse.fromJson(Map<String, dynamic> json) => PollResponse(
        pollId: json["pollId"],
        userId: json["userId"],
        question: json["question"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        answerType: json["answerType"],
        closedAt: json["closedAt"],
        createdAt: json["createdAt"],
        isVoted: json["isVoted"],
        status: json["status"],
        closedIn: json["closedIn"],
      );

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

class Answer {
  Answer({
    required this.dataType,
    required this.data,
    required this.voteCount,
    required this.isVotedByUser,
    required this.id,
  });

  final String dataType;
  final String data;
  final int voteCount;
  final bool isVotedByUser;
  final String id;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        dataType: json["dataType"],
        data: json["data"],
        voteCount: json["voteCount"],
        isVotedByUser: json["isVotedByUser"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "dataType": dataType,
        "data": data,
        "voteCount": voteCount,
        "isVotedByUser": isVotedByUser,
        "id": id,
      };
}
