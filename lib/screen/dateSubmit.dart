import 'package:final_real_again/constants/color.dart';
import 'package:final_real_again/data/evaluation.dart';
import 'package:final_real_again/screen/succesScreen%20.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AppointmentScreen extends StatefulWidget {
  final QuizSet quizSet;

  AppointmentScreen({required this.quizSet});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(); // เตรียมการแสดงวันที่ในรูปแบบภาษาไทย
  }

  String _getThaiYear(DateTime date) {
    final buddhistYear = date.year + 543; // คำนวณปีพ.ศ.
    return DateFormat.yMMMM('th_TH').format(date).replaceFirst(
        date.year.toString(), buddhistYear.toString()); // แทนที่ปีค.ศ.ด้วยพ.ศ.
  }

  @override
  Widget build(BuildContext context) {
    String timeSlot;
    if (widget.quizSet.name == "ตรวจสุขภาพ") {
      timeSlot = "ช่วงเวลาในการเข้าตรวจ : 7:30 - 17:00";
    } else if (widget.quizSet.name == "เลิกบุหรี่") {
      timeSlot = "ช่วงเวลาในการเข้าตรวจ : 8:30 - 16:00";
    } else {
      timeSlot = "";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: bottomBarIconColor),
        title: Text(
          'ลงนัด',
          style: TextStyle(color: bottomBarIconColor),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Text(
            'เลือกวันที่ต้องการลงนัด${widget.quizSet.name}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(),
          ),
          TableCalendar(
            locale: 'th_TH', // ตั้งค่าให้ปฏิทินเป็นภาษาไทย
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            enabledDayPredicate: (day) {
              DateTime today = DateTime.now();
              DateTime comparisonDay = DateTime(day.year, day.month, day.day);

              if (comparisonDay
                      .isBefore(DateTime(today.year, today.month, today.day)) ||
                  comparisonDay.isAtSameMomentAs(
                      DateTime(today.year, today.month, today.day)) ||
                  day.weekday == 6 ||
                  day.weekday == 7) {
                return false;
              }
              return true;
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // อัปเดตวันที่ที่โฟกัส
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 187, 224, 255),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: nextButtonColor,
                shape: BoxShape.circle,
              ),
              disabledTextStyle: TextStyle(
                  color: Colors.grey), // ปรับแต่งสีของวันที่ไม่สามารถเลือกได้
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: subtextColor,
              ),
              formatButtonVisible: false,
              titleCentered: true,
              titleTextFormatter: (date, locale) =>
                  _getThaiYear(date), // แสดงเดือนและปีเป็นปีพ.ศ.
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'วันที่เลือก: ',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                    width:
                        10), // Add some space between the label and container
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      _selectedDay != null
                          ? '${DateFormat.yMMMMEEEEd('th_TH').format(_selectedDay!).replaceFirst(_selectedDay!.year.toString(), (_selectedDay!.year + 543).toString())}'
                          : 'ยังไม่ได้เลือกวันที่', // Show this text if _selectedDay is null
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text('$timeSlot', style: TextStyle(fontSize: 18.0)),
          // if (_selectedDay != null)
          //   Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Text(
          //       'คุณเลือกวันที่: ${DateFormat.yMMMMEEEEd('th_TH').format(_selectedDay!).replaceFirst(_selectedDay!.year.toString(), (_selectedDay!.year + 543).toString())}',
          //       style: TextStyle(fontSize: 18),
          //     ),
          //   ),
          SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              if (_selectedDay != null) {
                // QuickAlert.show(
                //   context: context,
                //   type: QuickAlertType.success,
                //   title:
                //       'คุณลงนัดสำหรับวันที่: ${DateFormat.yMMMMEEEEd('th_TH').format(_selectedDay!).replaceFirst(_selectedDay!.year.toString(), (_selectedDay!.year + 543).toString())} เรียบร้อยแล้ว',
                //   confirmBtnText: 'ตกลง',
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessScreen(
                      selectedDate: _selectedDay!,
                      quizSetName: widget.quizSet.name,
                    ),
                  ),
                );
              }
            },
            icon: Icon(Icons.check_circle),
            label: Text('ยืนยันการลงนัด'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: nextButtonColor,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Border radius
              ),
            ),
          ),
        ],
      ),
    );
  }
}
