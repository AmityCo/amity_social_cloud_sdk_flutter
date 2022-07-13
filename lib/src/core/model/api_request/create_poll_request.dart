// To parse this JSON data, do
//
//     final createPollRequest = createPollRequestFromJson(jsonString);

/// Create Poll Request class for API
class CreatePollRequest {
  /// Init Create Poll Request
  CreatePollRequest({
    required this.text,
    required this.question,
    required this.answers,
    required this.answerType,
    required this.closedIn,
  });

  /// Text
  final String text;

  /// Question
  final String question;

  /// Answer Option
  final List<CreatePollAnswerRequest> answers;

  /// Answer type (single/multiple)
  final dynamic answerType;

  /// close in
  final int closedIn;

  /// Factory method to get [CreatePollRequest] from json
  factory CreatePollRequest.fromJson(Map<String, dynamic> json) =>
      CreatePollRequest(
        text: json["text"],
        question: json["question"],
        answers: List<CreatePollAnswerRequest>.from(
            json["answers"].map((x) => CreatePollAnswerRequest.fromJson(x))),
        answerType: json["answerType"],
        closedIn: json["closedIn"],
      );

  /// Convert [CreatePollRequest] to Map
  Map<String, dynamic> toJson() => {
        "text": text,
        "question": question,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "answerType": answerType,
        "closedIn": closedIn,
      };
}

/// Answer Option for Create Poll
class CreatePollAnswerRequest {
  /// Init [CreatePollAnswerRequest]
  CreatePollAnswerRequest({
    required this.dataType,
    required this.data,
  });

  /// Answer Data Type
  final String dataType;

  /// Answer Option
  final String data;

  /// Factory method to generate [CreatePollAnswerRequest] from map
  factory CreatePollAnswerRequest.fromJson(Map<String, dynamic> json) =>
      CreatePollAnswerRequest(
        dataType: json["dataType"],
        data: json["data"],
      );

  /// Convert [CreatePollAnswerRequest] to Map
  Map<String, dynamic> toJson() => {
        "dataType": dataType,
        "data": data,
      };
}
