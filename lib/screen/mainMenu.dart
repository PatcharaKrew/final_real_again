import 'package:final_real_again/constants/color.dart';
import 'package:final_real_again/data/evaluation.dart';
import 'package:final_real_again/screen/questionscreen.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final List<QuizSet> quizSets = getSampleQuizSets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              color: appBarColor,
              child: Row(
                children: [
                  CircleAvatar(
                    child: Image.asset(
                      'assets/images/logor.png',
                    ),
                    radius: 25.0,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'โรงพยาบาลพุธชินราช',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appBarTextColor),
                      ),
                      Text(
                        'นายพิสุท เวชกามา',
                        style: TextStyle(color: appBarTextColor),
                      )
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.logout),
                    color: appBarTextColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'รายการนัดที่ใกล้ถึง',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: textColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: nextButtonColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ตรวจสุขภาพ',
                                    style:
                                        TextStyle(color: nextButtonTextColor)),
                                Text('วันพุธ 11 ธ.ค. 2565',
                                    style:
                                        TextStyle(color: nextButtonTextColor)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(),
                ),
                Column(
                  children: List.generate(quizSets.length, (index) {
                    return HealthButton(
                      quizSet: quizSets[index],
                    );
                  }),
                )
              ])),
              
            ),
          ],
        ),
      ),
    );
  }
}

class HealthButton extends StatelessWidget {
  final QuizSet quizSet;

  HealthButton({super.key, required this.quizSet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionScreen(quizSet: quizSet),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: onPageButtonColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(children: [
            Icon(quizSet.icon, size: 40, color: nextButtonColor),
            SizedBox(width: 25),
            Text(
              quizSet.name,
              style: TextStyle(
                  fontSize: 28, color: textColor, fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }
}
