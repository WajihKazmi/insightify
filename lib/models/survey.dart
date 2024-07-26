import 'package:flutter/material.dart';

class Survey {
  List<Question> questions = [];
  String title;

  Survey({
    required this.title,
  });

  void addQuestion(Question question) {
    questions.add(question);
  }

  void deleteQuestion(int index) {
    if (index >= 0 && index < questions.length) {
      questions.removeAt(index);
    }
  }

  Question getQuestion(int index) {
    if (index >= 0 && index < questions.length) {
      return questions[index];
    } else {
      throw Exception("Index out of range");
    }
  }

  void deleteAllQuestions() {
    questions.clear();
  }

  void updateQuestion(int index, Question newQuestion) {
    if (index >= 0 && index < questions.length) {
      questions[index] = newQuestion;
    } else {
      throw Exception("Index out of range");
    }
  }
}

class Question {
  String content;
  String? description;
  List<String> choices = [];

  Question({required this.content});
}

class SurveyController extends ChangeNotifier {
  Survey _survey = Survey(title: "Untitled Survey");

  Survey get survey => _survey;

  List<Survey> _surveys = [];
  List<Survey> get surveys => _surveys;

  // Method to add a question
  void addQuestion(Question question) {
    _survey.addQuestion(question);
    notifyListeners();
  }

  // Method to delete a question by index
  void deleteQuestion(int index) {
    _survey.deleteQuestion(index);
    notifyListeners();
  }

  // Method to get a question by index
  Question getQuestion(int index) {
    return _survey.getQuestion(index);
  }

  // Method to delete all questions
  void deleteAllQuestions() {
    _survey.deleteAllQuestions();
    notifyListeners();
  }

  // Method to update a question by index
  void updateQuestion(int index, Question newQuestion) {
    _survey.updateQuestion(index, newQuestion);
    notifyListeners();
  }
}
