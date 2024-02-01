import 'package:first_project/backend.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'drawer.dart';

class TeacherSchedule extends StatefulWidget {

  final String teachID;
  final String fullName;

  const TeacherSchedule(
      this.teachID,
      this.fullName,
      {super.key});

  @override
  State<TeacherSchedule> createState() => _TeacherScheduleState();
}

class _TeacherScheduleState extends State<TeacherSchedule> {

  List<dynamic> schedData = [];



  void initState(){
    getSched();
    super.initState();
  }

  getSched() async {
    var dataGet = await BaseClient().getWithID(widget.teachID, '/getTeacherSchedule.php');

    setState(() {
      schedData = dataGet;

    });

  }

  void refreshPage (){
    setState(() {
      //just a refresh no biggie
    });
  }

  void _showAddScheduleDialog(BuildContext context) {
    // Define variables for date and time
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Schedule'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10,),
              Text('Current Date: ${selectedDate.toString().split(' ')[0]}'),
              TextButton(
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Text('Select Date'),
              ),

              Text('Current Time: ${selectedTime.format(context)}'),
              SizedBox(height: 10,),

              TextButton(
                onPressed: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (pickedTime != null && pickedTime != selectedTime) {
                    setState(() {
                      selectedTime = pickedTime;
                    });
                  }
                },
                child: Text('Select Time'),
              ),

              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // Perform action with selected date and time

                  String date = DateFormat('yyyy-MM-dd').format(selectedDate);
                  String minuteString = selectedTime.minute < 10 ? '0${selectedTime.minute}' : '${selectedTime.minute}';
                  String time = '${selectedTime.hour}:$minuteString:00';
                  print('Selected Date: $date');
                  print('Selected Time: $time');
                  print(widget.teachID);

                  await BaseClient().insertScheduleTeacher('/insertNewSchedule.php', date, time, widget.teachID);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherSchedule(widget.teachID, widget.fullName))); // Close the dialog
                },
                child: Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'My Schedule',
            style: TextStyle(
              color: Color(0xFF1f1b4f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: SidebarDrawer(widget.teachID),
      body:


      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFF1f1b4f),
                      child: Text(
                        widget.fullName[0],
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
                      widget.fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF1f1b4f),
                      ),
                    ),

              ],
            ),
              SizedBox(height: 10),


              ],

            ),

            SizedBox(height: 10),
            const Text('Schedules:',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF1f1b4f),
              ),
            ),

            Container(
                child: Expanded(
                  child: ListView.builder(
                    itemCount: schedData.length,
                    itemBuilder: (context, index) {
                      return
                        Container(width: double.infinity,
                          child: ListTile(
                            title:
                              ScheduleDetails(
                                availableDate: schedData[index]["date"],
                                time: schedData[index]["time"],
                                status: schedData[index]["status"]
                                ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await BaseClient().deleteWithID('/deleteSchedule.php', schedData[index]["avail_id"]);

                                Navigator.push(context, MaterialPageRoute(builder: (context)=> TeacherSchedule(widget.teachID, widget.fullName)));
                              },
                            ),
                          )
                        );

                    },
                  ),
                ),

            )
        ]
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddScheduleDialog(context);
        },
        child: Icon(Icons.add,
          color: Colors.amber,
        ),
        backgroundColor: Color(0xFF1f1b4f),
    ),

    );
  }
}


class ScheduleDetails extends StatelessWidget {
  final String availableDate;
  final String time;
  final String status;

  ScheduleDetails({
    required this.availableDate,
    required this.time,
    required this.status
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                'Date: $availableDate',
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
              SizedBox(height: 8),

              Text(
                'Status: $status',
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


