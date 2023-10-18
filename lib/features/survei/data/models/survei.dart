import 'package:synapsis_challenge/features/survei/domain/entity/survei.dart';

class SurveiModel extends SurveiEntity {
  SurveiModel(
      {required super.id,
      required super.surveyName,
      required super.status,
      required super.totalRespondent,
      required super.createdAt,
      required super.updatedAt});

  factory SurveiModel.fromJson(Map<String, dynamic> json) {
    return SurveiModel(
      id: json['id'],
      surveyName: json['survey_name'],
      status: json['status'],
      totalRespondent: json['total_respondent'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
