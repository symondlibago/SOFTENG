import 'package:first_project/backend.dart';
import 'package:flutter/material.dart';
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
      drawer: SidebarDrawer(),
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


//
// void showCommentDialog(BuildContext context) {
//
// // FLOATING BUTTON ACTION WHERE I ADD A DATE AND TIME FAK THIS
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Add Schedule'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             accept
//                 ? Text('Details for Meetup')
//                 : Text('Reason for Rejection')
//             ,
//             TextField(
//               controller: commentController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 hintText: 'Enter your comment here...',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: commentController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 hintText: 'Enter your comment here...',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             Column(
//                 children:[ ElevatedButton(
//                   onPressed: () async {
//
//                     String comment = commentController.text;
//
//
//                     await BaseClient().acceptAppointment('/acceptAppointment.php', pendingID, comment)
//
//
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xFF1f1b4f),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   child: const Text("Submit",
//                     style: TextStyle(
//                       color: Color.fromRGBO(250, 180, 23, 1),
//                     ),
//                   ),
//                 ),
//                 ]
//             )
//           ],
//         ),
//       );
//     },
//   );
// }
