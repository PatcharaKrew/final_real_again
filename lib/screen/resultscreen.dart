import 'package:final_real_again/constants/color.dart';
import 'package:final_real_again/data/evaluation.dart';
import 'package:final_real_again/screen/dateSubmit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                if (quizSet.name == "ตรวจสุขภาพ") ...[
                  Text('แบบประเมินความเสี่ยงสุขภาพ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: textColor)),
                  Text('ผลการประเมิน : $totalScore คะแนน',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: subtextColor,
                      )),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SpinKitRipple(
                        color: Color(0xFFDD3F43).withOpacity(0.7),
                        size: 270.0,
                      ),
                      ClipOval(
                        child: Image.asset(
                          'assets/images/Heal.png',
                          width: 250.0,
                          height: 250.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  buildEvaluationButton(totalScore),
                ],
                if (quizSet.name == "HIV") ...[
                  Text('โปรแกรมตรวจ HIV',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: textColor)),
                  SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipPath(
                        child: Image.asset(
                          'assets/images/hiv.png',
                          width: 250.0,
                          height: 250.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                      'คุณต้องการ : ${quizSet.questions[0].answers[selectedAnswers[0]].text}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22.0, color: subtextColor)),
                  SizedBox(height: 10),
                ],
                if (quizSet.name == "เลิกบุหรี่") ...[
                  Text('แบบประเมินวัดระดับการติดนิโคติน',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: textColor)),
                  Text('ผลการประเมินของได้ $totalScore คะแนน',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22.0, color: subtextColor)),
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/images/smoke.png',
                    fit: BoxFit.fill,
                  ),
                  smokerneenaa(totalScore),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        icon: Icon(Icons.home_outlined),
                        label: Text('หน้าหลัก', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: buttonTextColor,
                          backgroundColor: nextButtonColor,
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15.0), // Border radius
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0), // ระยะห่างระหว่างปุ่ม
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentScreen(
                                quizSet: quizSet,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.calendar_month_outlined),
                        label: Text('ลงนัด', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: buttonTextColor,
                          backgroundColor: nextButtonColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0), // ใช้ padding แนวตั้งเท่านั้น
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15.0), // Border radius
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEvaluationButton(int score) {
    String text;
    Color color;
    Color textColor;

    if (score >= 10 && score <= 6) {
      text = 'เสี่ยงสูง';
      color = Colors.red[100]!;
      textColor = Colors.red;
    } else if (score >= 4) {
      text = 'เสี่ยงปานกลาง';
      color = Colors.yellow[100]!;
      textColor = Colors.yellow[800]!;
    } else if (score >= 0 && score <= 3) {
      text = 'เสี่ยงต่ำ';
      color = Colors.green[100]!;
      textColor = Colors.green;
    } else {
      text = 'error';
      color = Colors.grey[100]!;
      textColor = Colors.black;
    }
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
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

  Widget smokerneenaa(int score) {
    String text;
    Color color;
    Color textColor;

    if (score >= 10 && score <= 6) {
      text = 'ติดบุหรี่มาก';
      color = Colors.red[100]!;
      textColor = Colors.red;
    } else if (score >= 4) {
      text = 'ติดบุหรี่ปานกลาง';
      color = Colors.yellow[100]!;
      textColor = Colors.yellow[800]!;
    } else if (score >= 0 && score <= 3) {
      text = 'ติดบุหรี่น้อย';
      color = Colors.green[100]!;
      textColor = Colors.green;
    } else {
      text = 'error';
      color = Colors.grey[100]!;
      textColor = Colors.black;
    }
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
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
