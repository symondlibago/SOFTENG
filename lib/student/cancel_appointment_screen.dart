import 'package:first_project/backend.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'cancel_appointment.dart';
class PendingAppointment extends StatefulWidget {

  final String studID;

  const PendingAppointment(
      this.studID,
      {super.key});



  @override
  State<PendingAppointment> createState() => _PendingAppointmentState();
}

class _PendingAppointmentState extends State<PendingAppointment> {

  List<dynamic> pendingData = [];

  void initState(){
    getData();
    super.initState();
  }

  getData() async {
    var data = await BaseClient().getWithID(widget.studID, '/getPendingStudAppointments.php');

    setState(() {
      pendingData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Pending Appointments',
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
              Expanded(child:
                ListView.builder(
                    itemCount: pendingData.length,
                    itemBuilder: (context, index){
                      return Container(width: double.infinity,
                          child: ListTile(
                            title:
                            ScheduleDetails(
                                name: '${pendingData[index]["name"]} ${pendingData[index]["last_name"]}',
                                availableDate: pendingData[index]["date"],
                                time: pendingData[index]["time"],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () async {
                                await BaseClient().deleteWithID('/deletePending.php', pendingData[index]["pending_id"]);

                                Navigator.push(context, MaterialPageRoute(builder: (context)=> (PendingAppointment(widget.studID))));
                              },
                            ),
                          )
                      );
                    })
              )
            ],
    ),
    )
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
                '$availableDate',
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
