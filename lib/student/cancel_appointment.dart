import 'package:flutter/material.dart';
import 'drawer.dart';

class CancelAppointment extends StatelessWidget {
  final String studID;
  final String avatarText;
  final String name;
  final String availableDate;
  final String time;

  CancelAppointment({
    required this.studID,
    required this.avatarText,
    required this.name,
    required this.availableDate,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Cancel Appointment',
            style: TextStyle(
              color: Color(0xFF1f1b4f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: SidebarDrawer(studID),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileInfo(
              avatarText: avatarText,
              name: name,
              availableDate: availableDate,
              time: time,
            ),
            SizedBox(height: 20),
            DateAndTimeInput(),
            SizedBox(height: 20),
            ReasonForAppointmentInput(),
            SizedBox(height: 20),
            BookButton(),
          ],
        ),
      ),
    );
  }
}

class UserProfileInfo extends StatelessWidget {
  final String avatarText;
  final String name;
  final String availableDate;
  final String time;

  UserProfileInfo({
    required this.avatarText,
    required this.name,
    required this.availableDate,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0), // Margin for spacing
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFF1f1b4f),
            child: Text(
              avatarText,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8),
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
                'Available on $availableDate at $time',
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

class DateAndTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MM/DD/YY',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1f1b4f),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF1f1b4f),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8.0),
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Time',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1f1b4f),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF1f1b4f),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8.0),
            ),
          ),
        ),
      ],
    );
  }
}

class ReasonForAppointmentInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reason for Canceling',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1f1b4f),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF1f1b4f),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            maxLines: 3,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8.0),
            ),
          ),
        ),
      ],
    );
  }
}

class BookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF1f1b4f),
        ),
        child: Text(
          'Submit',
          style: TextStyle(
            color: Color.fromRGBO(250, 180, 23, 1),
          ),
        ),
      ),
    );
  }
}
