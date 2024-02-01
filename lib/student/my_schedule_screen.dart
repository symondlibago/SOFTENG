import 'package:first_project/backend.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class MyScheduleScreen extends StatefulWidget {

  final String studID;

  const MyScheduleScreen(
      this.studID,
      {super.key});

  @override
  State<MyScheduleScreen> createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen> {

  List<dynamic> getData = [];

  void initState(){
    getAppoints();
    super.initState();
  }

  getAppoints() async {
    var dataRetrieve = await BaseClient().getWithID(widget.studID, '/getStudentAppointment.php');

    setState(() {
      getData = dataRetrieve;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Appointments',
            style: TextStyle(
              color: Color(0xFF1f1b4f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: SidebarDrawer(widget.studID),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: getData.length,
                  itemBuilder: (context, index){
                    return ScheduleItem(
                        title: '${getData[index]["name"]} ${getData[index]["last_name"]}',
                        time: getData[index]["time"],
                        date: getData[index]["date"],
                        location: getData[index]["details"]
                    );
                  }
              ),
            ),
          ],
        ),
      ),
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
