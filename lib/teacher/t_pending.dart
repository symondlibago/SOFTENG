import 'package:flutter/material.dart';
import '../backend.dart';
import 'drawer.dart';
import 't_cancel_appointment.dart';

class PendingAppointments extends StatefulWidget {

  final String teachID;

  const PendingAppointments(this.teachID, {super.key});

  @override
  State<PendingAppointments> createState() => _PendingAppointmentsState();
}

class _PendingAppointmentsState extends State<PendingAppointments> {

  List<dynamic> dataList = [];

  @override
  void initState(){
    getSchedData();
    super.initState();
  }

  getSchedData() async {
    var dataGet = await BaseClient().getWithID(widget.teachID, '/getAppointment.php');

    print(dataGet);
    setState(() {
      dataList = dataGet;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.teachID);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Request',
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
        child:
          ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index){

                  return InkWell(
                    onTap: () {


                      String firstLetter = dataList[index]["student_name"];

                      // Navigate to the BookAppointment page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CancelAppointment(
                              teachID: widget.teachID,
                              pendingID: dataList[index]["pending_id"],
                              avatarText: firstLetter.substring(0, 1).toUpperCase(),
                              name: dataList[index]["student_name"],
                              availableDate: dataList[index]["date"],
                              time: dataList[index]["time"],
                              reason: dataList[index]["reason"],

                            ),
                        ),
                      );
                    },
                    child: ScheduleDetails(
                      name: dataList[index]["student_name"],
                      availableDate: '${dataList[index]["date"]}',
                      time: '${dataList[index]["time"]}',
                    ),
                  );

             }
          )
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
