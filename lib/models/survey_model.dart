// lib/models/survey_question.dart

class SurveyQuestion {
  final String id;
  final String type;
  final String question;
  final List<String>? options;
  final String? hint;

  SurveyQuestion({
    required this.id,
    required this.type,
    required this.question,
    this.options,
    this.hint,
  });

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) {
    return SurveyQuestion(
      id: json['id'],
      type: json['type'],
      question: json['question'],
      options: json['options']?.cast<String>(),
      hint: json['hint'],
    );
  }
}

class Survey {
  final String surveyId;
  final String title;
  final List<SurveyQuestion> questions;

  Survey({
    required this.surveyId,
    required this.title,
    required this.questions,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    var questionsList = json['questions'] as List;
    List<SurveyQuestion> questions = questionsList
        .map((questionJson) => SurveyQuestion.fromJson(questionJson))
        .toList();

    return Survey(
      surveyId: json['survey_id'],
      title: json['title'],
      questions: questions,
    );
  }
}