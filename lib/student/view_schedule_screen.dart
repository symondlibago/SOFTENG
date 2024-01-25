import 'package:first_project/backend.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'book_appointment.dart';

class ViewScheduleScreen extends StatefulWidget {

  final String studID;
  

  const ViewScheduleScreen(this.studID, {super.key});

  @override
  State<ViewScheduleScreen> createState() => _ViewScheduleScreenState();
}

class _ViewScheduleScreenState extends State<ViewScheduleScreen> {
  
  List<dynamic> dataList = [];
  
  @override
  void initState(){
    getSchedData();
    super.initState();
  }
  
  getSchedData() async {
    var dataGet = await BaseClient().getData('/getSchedule.php');

    setState(() {
      dataList = dataGet;
    });
  }
  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'View Available Schedule',
            style: TextStyle(
              color: Color(0xFF1f1b4f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: const SidebarDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {
                      String fullname = '${dataList[index]["name"]} ${dataList[index]["last_name"]}';
                      print(fullname);
                      print(widget.studID);
                      print(dataList[index]["avail_id"]);
                      String firstLetter = dataList[index]["name"];

                      // Navigate to the BookAppointment page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookAppointment(
                            widget.studID,
                            dataList[index]["avail_id"],
                            firstLetter.substring(0, 1).toUpperCase(),
                            fullname,
                            dataList[index]["date"],
                            dataList[index]["time"]
                          ),
                        ),
                      );
                    },
                    child: ScheduleDetails(
                      name: '${dataList[index]["name"]} ${dataList[index]["last_name"]}',
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
