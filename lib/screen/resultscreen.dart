import 'package:final_real_again/constants/color.dart';
import 'package:final_real_again/data/evaluation.dart';
import 'package:final_real_again/screen/mainMenu.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final QuizSet quizSet;
  final List<int> selectedAnswers;

  ResultScreen({required this.quizSet, required this.selectedAnswers});

  @override
  Widget build(BuildContext context) {
    int totalScore = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      int selectedIndex = selectedAnswers[i];
      if (selectedIndex >= 0 &&
          selectedIndex < quizSet.questions[i].answers.length) {
        totalScore += quizSet.questions[i].answers[selectedIndex].score;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: bottomBarIconColor),
        title: Text(
          quizSet.name,
          style: TextStyle(color: bottomBarIconColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (quizSet.name == "ตรวจสุขภาพ") ...[
                Text('คะแนนรวม: $totalScore', style: TextStyle(fontSize: 24.0)),
                buildEvaluationButton(totalScore),
              ],
              if (quizSet.name == "HIV") ...[
                Text(
                    'ตัวเลือกที่เลือกในคำถามข้อแรก: ${quizSet.questions[0].answers[selectedAnswers[0]].text}',
                    style: TextStyle(fontSize: 24.0)),
                // Image.asset(
                //     'assets/smoking_cessation_image.png'), // ตัวอย่างรูปภาพ
              ],
              if (quizSet.name == "เลิกบุหรี่") ...[
                Text(
                    'ตัวเลือกที่เลือกในคำถามข้อแรก: ${quizSet.questions[0].answers[selectedAnswers[0]].text}',
                    style: TextStyle(fontSize: 24.0)),
                // Image.asset(
                //     'assets/smoking_cessation_image.png'), // ตัวอย่างรูปภาพ
              ],
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AppointmentScreen(
                  //       quizSet: quizSet,
                  //     ),
                  //   ),
                  // );
                },
                child: Text('ลงนัด'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomeScreen(),
                  //   ),
                  // );
                },
                child: Text('กลับไปหน้าหลัก'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEvaluationButton(int score) {
    String text;
    Color color;
    Color textColor;

    if (score >= 15) {
      text = 'ยอดเยี่ยม';
      color = Colors.red[100]!;
      textColor = Colors.red;
    } else if (score >= 10) {
      text = 'ดี';
      color = Colors.yellow[100]!;
      textColor = Colors.yellow[800]!;
    } else if (score >= 5) {
      text = 'พอใช้';
      color = Colors.green[100]!;
      textColor = Colors.green;
    } else {
      text = 'ควรปรับปรุง';
      color = Colors.grey[100]!;
      textColor = Colors.black;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
