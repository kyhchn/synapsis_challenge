class UserAnswerEntity {
  String surveyId;
  List<Answer> answers;

  UserAnswerEntity({required this.surveyId, required this.answers});
}

class Answer {
  String questionId;
  String? answer;

  Answer({this.answer, required this.questionId});
}
