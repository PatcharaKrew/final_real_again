import 'package:final_real_again/constants/color.dart';
import 'package:flutter/material.dart';

class Appointment {
  final String title;
  final String date;
  final String time;

  Appointment({
    required this.title,
    required this.date,
    required this.time,
  });

  IconData get icon {
    if (title == 'ตรวจสุขภาพ') {
      return Icons.monitor_heart;
    } else if (title == 'เลิกบุหรี่') {
      return Icons.smoke_free;
    } else if (title == 'HIV') {
      return Icons.health_and_safety;
    } else {
      return Icons.error;
    }
  }

  String get timeSlot {
    if (title == 'ตรวจสุขภาพ') {
      return 'ช่วงเวลาในการเข้าตรวจ : 7:30 - 17:00';
    } else if (title == 'เลิกบุหรี่') {
      return 'ช่วงเวลาในการเข้าตรวจ : 8:30 - 16:00';
    } else {
      return '';
    }
  }
}

List<Appointment> appointments = [
  Appointment(
    title: 'ตรวจสุขภาพ',
    date: 'วันพุธที่ 21 สิงหาคม 2567',
    time: 'เวลา 7:00 - 16:00',
  ),
  Appointment(
    title: 'เลิกบุหรี่',
    date: 'วันพุธที่ 21 สิงหาคม 2567',
    time: 'เวลา 7:00 - 16:00',
  ),
  Appointment(
    title: 'HIV',
    date: 'วันพุธที่ 21 สิงหาคม 2567',
    time: 'เวลา 7:00 - 16:00',
  ),
];

class AppointmentDetails extends StatefulWidget {
  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  void _removeAppointment(int index) {
    setState(() {
      appointments.removeAt(index);
    });
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('คุณต้องการจะลบ'),
          actions: <Widget>[
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('ตกลง'),
              onPressed: () {
                _removeAppointment(index); // Remove the appointment
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'รายการนัดหมาย',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appoiment = appointments[index];
                    return Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: const Color.fromARGB(255, 123, 123, 123),
                            width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  appoiment.icon,
                                  color: nextButtonColor,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  appoiment.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'วันที่: ${appoiment.date}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: textColor,
                                      ),
                                    )
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: Text(
                                  appoiment.timeSlot,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: subtextColor,
                                  ),
                                )),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: bottomBarIconColor,
                                  backgroundColor: nextButtonColor,
                                  fixedSize: Size(double.maxFinite, 40),
                                  // padding:
                                  //     EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  _showDeleteConfirmationDialog(index);
                                },
                                child: Text('ยกเลิกนัดหมาย'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ]),
      ),
    );
  }
}
