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
    } else if (title == 'ตรวจสุขภาพ') {
      return Icons.health_and_safety;
    } else {
      return Icons.error;
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
    title: 'ตรวจสุขภาพ',
    date: 'วันพุธที่ 21 สิงหาคม 2567',
    time: 'เวลา 7:00 - 16:00',
  ),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppointmentDetails(),
    );
  }
}

class AppointmentDetails extends StatefulWidget {
  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
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
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: const Color.fromARGB(255, 123, 123, 123), width: 0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        appointment.icon,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        appointment.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.date,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        Spacer(),
                        Text(
                          appointment.time,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      appointment.time,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.lightBlueAccent,
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
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
