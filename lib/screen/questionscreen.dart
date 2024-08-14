import 'package:final_real_again/constants/color.dart';
import 'package:final_real_again/data/evaluation.dart';
import 'package:final_real_again/screen/resultscreen.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final QuizSet quizSet;

  QuestionScreen({required this.quizSet});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentQuestionIndex = 0;
  List<int> _selectedAnswers = List.filled(1, -1); //8
  List<int> _selectedAnswersHIV = List.filled(1, -1);
  List<int> _selectedAnswersSmoking = List.filled(1, -1); //8

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex == 1 &&
          widget.quizSet.name == "ตรวจสุขภาพ" &&
          _selectedAnswers[_currentQuestionIndex] != 0) {
        _currentQuestionIndex +=
            2; // ข้ามคำถามข้อที่ 2 ถ้าไม่ได้ตอบตัวเลือกที่ 1
      } else {
        _currentQuestionIndex++;
      }
    });
  }

  void _prevQuestion() {
    setState(() {
      if (_currentQuestionIndex == 3 &&
          widget.quizSet.name == "ตรวจสุขภาพ" &&
          _selectedAnswers[1] != 0) {
        _currentQuestionIndex -=
            2; // กลับไปคำถามข้อที่ 2 ถ้าเคยข้ามคำถามข้อที่ 2
      } else {
        _currentQuestionIndex--;
      }
    });
  }

  void _submitQuiz() {
    List<int> selectedAnswers;
    if (widget.quizSet.name == "ตรวจสุขภาพ") {
      selectedAnswers = _selectedAnswers;
    } else if (widget.quizSet.name == "เลิกบุหรี่") {
      selectedAnswers = _selectedAnswersSmoking;
    } else if (widget.quizSet.name == "HIV") {
      selectedAnswers = _selectedAnswersHIV;
    } else {
      selectedAnswers = [];
    }

    // Mark any unanswered question with an answer index that corresponds to a score of 0
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == -1) {
        selectedAnswers[i] = widget.quizSet.questions[i].answers
            .indexWhere((answer) => answer.score == 0);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          quizSet: widget.quizSet,
          selectedAnswers: selectedAnswers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.quizSet.questions[_currentQuestionIndex];
    final selectedAnswers;
    if (widget.quizSet.name == "ตรวจสุขภาพ") {
      selectedAnswers = _selectedAnswers;
    } else if (widget.quizSet.name == "เลิกบุหรี่") {
      selectedAnswers = _selectedAnswersSmoking;
    } else if (widget.quizSet.name == "HIV") {
      selectedAnswers = _selectedAnswersHIV;
    } else {
      selectedAnswers = [];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: bottomBarIconColor),
        title: Text(
          widget.quizSet.name,
          style: TextStyle(color: bottomBarIconColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Text(
              currentQuestion.text,
              style: TextStyle(fontSize: 22.0),
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 10),
            ...currentQuestion.answers.map((answer) {
              int index = currentQuestion.answers.indexOf(answer);
              bool isSelected = selectedAnswers[_currentQuestionIndex] == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAnswers[_currentQuestionIndex] = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? appBarColor : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: nextButtonColor, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      answer.text,
                      style: TextStyle(
                        fontSize: 18,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: _prevQuestion,
                    child: Text('ย้อนกลับ',style: TextStyle(fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: buttonTextColor,
                      backgroundColor: nextButtonColor, // Text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Border radius
                      ),
                    ),
                  ),
                Spacer(),
                if (_currentQuestionIndex < widget.quizSet.questions.length - 1)
                  ElevatedButton(
                    onPressed: selectedAnswers[_currentQuestionIndex] == -1
                        ? null
                        : _nextQuestion,
                    child: Text('ถัดไป',style: TextStyle(fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: buttonTextColor,
                      backgroundColor: nextButtonColor, // Text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Border radius
                      ),
                    ),
                  ),
                if (_currentQuestionIndex ==
                    widget.quizSet.questions.length - 1)
                  ElevatedButton(
                    onPressed: selectedAnswers[_currentQuestionIndex] == -1
                        ? null
                        : _submitQuiz,
                    child: Text('Submit',style: TextStyle(fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: buttonTextColor,
                      backgroundColor: nextButtonColor, // Text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Border radius
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}