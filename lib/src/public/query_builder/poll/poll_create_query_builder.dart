import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/domain/domain.dart';

/// Poll Create Query Builder
class PollCreateQueryBuilder {
  final CreatePollUseCase _useCase;
  final String _question;

  /// Init [PollCreateQueryBuilders]
  PollCreateQueryBuilder(this._useCase, this._question);

  /// Add Answer to poll
  SubmitPollCreateQueryBuilder answers(
      {required List<AmityPollAnswer> answers}) {
    return SubmitPollCreateQueryBuilder(_useCase, _question, answers);
  }
}

/// Submit Poll Create Query Builder
class SubmitPollCreateQueryBuilder {
  final CreatePollUseCase _useCase;
  final String _question;
  final List<AmityPollAnswer> _answers;
  AmityPollAnswerType _answerType = AmityPollAnswerType.SINGLE;
  Duration? _closedIn;

  /// Init [SubmitPollCreateQueryBuilder]
  SubmitPollCreateQueryBuilder(this._useCase, this._question, this._answers);

  /// Set Answer type for the poll
  SubmitPollCreateQueryBuilder answerType(
      {required AmityPollAnswerType answerType}) {
    _answerType = answerType;
    return this;
  }

  /// Set close time for the poll
  SubmitPollCreateQueryBuilder closedIn({required Duration closedIn}) {
    _closedIn = closedIn;
    return this;
  }

  /* begin_public_function 
  id: poll.create
  */
  /// Create Poll
  Future<AmityPoll> create() {
    CreatePollRequest request = CreatePollRequest(
        text: _question,
        question: _question,
        answers: _answers
            .map((e) =>
                CreatePollAnswerRequest(data: e.data!, dataType: e.dataType!))
            .toList(),
        answerType: _answerType.value,
        closedIn: _closedIn?.inMilliseconds ?? 0);
    print(request.toString());
    final data = _useCase.get(request);
    return data;
  }
  /* end_public_function */
}
