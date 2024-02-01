import 'package:flutter/material.dart';
import '../backend.dart';
import 'drawer.dart';

class MyAppointments extends StatefulWidget {
  final String teachID;

  const MyAppointments(
      this.teachID,
      {super.key});

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {

  List<dynamic> appointmentData = [];



  @override
  void initState(){
    getUserData();
    super.initState();
  }


  getUserData() async {
    var getUser = await BaseClient().getWithID(widget.teachID, '/getMyAppointments.php');

    setState(() {
      appointmentData = getUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.teachID);
    print(appointmentData);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'My Appointments',
            style: TextStyle(
              color: Color(0xFF1f1b4f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: SidebarDrawer(widget.teachID),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Appointments(appointmentData), // Use the Schedule widget here
      ),
    );;
  }
}


class Appointments extends StatelessWidget {

  final List<dynamic> studentData;

  const Appointments(
      this.studentData,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return
        ListView.builder(
            itemCount: studentData.length,
            itemBuilder: (context, index){
              return ScheduleItem(
                  title: '${studentData[index]["name"]} ${studentData[index]["last_name"]}',
                  time: studentData[index]["time"],
                  date: studentData[index]["date"],
                  location: studentData[index]["details"]
              );
            }
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
