class SurveiDetailEntity {
  String id;
  String surveyName;
  int status;
  int totalRespondent;
  DateTime createdAt;
  DateTime updatedAt;
  List<Question> questions;

  SurveiDetailEntity({
    required this.id,
    required this.surveyName,
    required this.status,
    required this.totalRespondent,
    required this.createdAt,
    required this.updatedAt,
    required this.questions,
  });
}

class Question {
  String id;
  int questionNumber;
  String surveyId;
  String section;
  String inputType;
  String questionName;
  String questionSubject;
  List<Option> options;

  Question({
    required this.id,
    required this.questionNumber,
    required this.surveyId,
    required this.section,
    required this.inputType,
    required this.questionName,
    required this.questionSubject,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionNumber: json['question_number'],
      surveyId: json['survey_id'],
      section: json['section'],
      inputType: json['input_type'],
      questionName: json['question_name'],
      questionSubject: json['question_subject'],
      options: json['options']
          .map<Option>((option) => Option.fromJson(option))
          .toList(),
    );
  }
}

class Option {
  String id;
  String questionId;
  String optionName;
  int value;
  String color;

  Option({
    required this.id,
    required this.questionId,
    required this.optionName,
    required this.value,
    required this.color,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      questionId: json['question_id'],
      optionName: json['option_name'],
      value: json['value'],
      color: json['color'],
    );
  }
}
