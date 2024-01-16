import 'package:flutter/material.dart';
import 't_drawer.dart';
import 't_book_appointment.dart';

class ViewScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'View Available Schedule',
            style: TextStyle(
              color: Color(0xFF1f1b4f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: SidebarDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Navigate to the BookAppointment page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookAppointment(
                      avatarText: 'J',
                      name: 'John Doe',
                      availableDate: 'January 13, 2024',
                      time: '2:00 PM',
                    ),
                  ),
                );
              },
              child: ScheduleDetails(
                name: 'John Doe',
                availableDate: 'January 13, 2024',
                time: '2:00 PM',
              ),
            ),
            InkWell(
              onTap: () {
                // Navigate to the BookAppointment page for Jane Smith
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookAppointment(
                      avatarText: 'J',
                      name: 'Jane Smith',
                      availableDate: 'February 20, 2024',
                      time: '3:30 PM',
                    ),
                  ),
                );
              },
              child: ScheduleDetails(
                name: 'Jane Smith',
                availableDate: 'February 20, 2024',
                time: '3:30 PM',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleDetails extends StatelessWidget {
  final String name;
  final String availableDate;
  final String time;

  ScheduleDetails({
    required this.name,
    required this.availableDate,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF1f1b4f),
                child: Text(
                  name[0],
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1f1b4f),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Available on $availableDate',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1f1b4f),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Time: $time',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1f1b4f),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
