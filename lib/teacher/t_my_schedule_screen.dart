import 'package:flutter/material.dart';
import 't_drawer.dart';

class MyScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Schedule',
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
        child: Schedule(), // Use the Schedule widget here
      ),
    );
  }
}

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScheduleItem(
          title: 'Mrs. Love Perez',
          time: '2:00 PM',
          date: 'November 10, 2023',
          location: 'CITC building, 4th floor, Chairman\'s Office',
        ),
        ScheduleItem(
          title: 'Ms. Nina Dobrev',
          time: '1:00 PM',
          date: 'November 13, 2023',
          location: 'CITC building, 1st floor, Dean\'s Office',
        ),
        ScheduleItem(
          title: 'Mr. Paul Wesly',
          time: '3:00 PM',
          date: 'November 13, 2023',
          location: 'CITC building, 1st floor, Dean\'s Office',
        ),
        ScheduleItem(
          title: 'Mr. Chris Wood',
          time: '9:30 AM',
          date: 'December 10, 2023',
          location: 'CITC building, 4th floor, Chairman\'s Office',
        ),
      ],
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final String title;
  final String time;
  final String date;
  final String location;

  ScheduleItem({
    required this.title,
    required this.time,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40, // Increased the size
                  backgroundColor: Color(0xFF1f1b4f),
                  child: Text(
                    title[0],
                    style: TextStyle(
                      fontSize: 24, // Increased the size
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$time $date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1f1b4f),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1f1b4f),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1f1b4f),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
