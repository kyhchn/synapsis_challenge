import 'package:synapsis_challenge/features/survei-detail/domain/entity/survei_detail.dart';

class SurveiDetailModel extends SurveiDetailEntity {
  SurveiDetailModel(
      {required super.id,
      required super.surveyName,
      required super.status,
      required super.totalRespondent,
      required super.createdAt,
      required super.updatedAt,
      required super.questions});

  factory SurveiDetailModel.fromJson(Map<String, dynamic> json) {
    return SurveiDetailModel(
        id: json['id'],
        surveyName: json['survey_name'],
        status: json['status'],
        totalRespondent: json['total_respondent'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        questions: json['questions']
            .map<Question>((question) => Question.fromJson(question))
            .toList());
  }
}
