// lib/screens/quick_survey_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/survey_model.dart';
import 'widgets/survey_components.dart';

class QuickSurvey extends StatefulWidget {
  const QuickSurvey({super.key});

  @override
  State<QuickSurvey> createState() => _QuickSurveyState();
}

class _QuickSurveyState extends State<QuickSurvey> {
  Survey? _survey;
  final Map<String, String> _responses = {};

  @override
  void initState() {
    super.initState();
    _loadSurvey();
  }

  Future<void> _loadSurvey() async {
    try {
      final String response = await rootBundle.loadString('assets/surveys/quick_survey.json');
      final surveyJson = await json.decode(response);
      setState(() {
        _survey = Survey.fromJson(surveyJson);
      });
    } catch (e) {
      print('Error loading survey: $e');
    }
  }

  Widget _buildQuestionWidget(SurveyQuestion question) {
    switch (question.type) {
      case 'multiple_choice':
        return MultipleChoiceCard(
          question: question.question,
          options: question.options ?? [],
          onChanged: (value) {
            _responses[question.id] = value;
          },
        );
      case 'short_answer':
        return ShortAnswerCard(
          question: question.question,
          hintText: question.hint,
          onChanged: (value) {
            _responses[question.id] = value;
          },
        );
      case 'long_answer':
        return LongAnswerCard(
          question: question.question,
          hintText: question.hint,
          onChanged: (value) {
            _responses[question.id] = value;
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_survey == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_survey!.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ..._survey!.questions.map(_buildQuestionWidget),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  print('Survey responses: $_responses');
                },
                child: const Text('Submit Survey'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}