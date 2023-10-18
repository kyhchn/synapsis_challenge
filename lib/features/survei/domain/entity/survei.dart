class SurveiEntity {
  String id;
  String surveyName;
  int status;
  int totalRespondent;
  DateTime createdAt;
  DateTime updatedAt;

  SurveiEntity({
    required this.id,
    required this.surveyName,
    required this.status,
    required this.totalRespondent,
    required this.createdAt,
    required this.updatedAt,
  });
}
