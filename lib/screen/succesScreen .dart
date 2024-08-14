import 'package:final_real_again/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class SuccessScreen extends StatelessWidget {
  final DateTime selectedDate;
  final String quizSetName;

  SuccessScreen({required this.selectedDate, required this.quizSetName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // แสดงอนิเมชัน Lottie
            Lottie.asset(
              'assets/animations/success.json', // ใส่ path ของไฟล์ Lottie ของคุณ
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'ดำเนินการลงนัดสำเร็จ!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${DateFormat.yMMMMEEEEd('th_TH').format(selectedDate).replaceFirst(selectedDate.year.toString(), (selectedDate.year + 543).toString())}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'โปรแกรมนัด: $quizSetName',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('ตกลง',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: buttonTextColor)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                backgroundColor: nextButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
