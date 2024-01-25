import 'package:first_project/backend.dart';
import 'package:first_project/teacher/t_pending.dart';
import 'package:first_project/teacher/t_active_appointments.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class CancelAppointment extends StatelessWidget {
  final String teachID;
  final String pendingID;
  final String avatarText;
  final String name;
  final String availableDate;
  final String time;
  final String reason;

  CancelAppointment({super.key,
    required this.teachID,
    required this.pendingID,
    required this.avatarText,
    required this.name,
    required this.availableDate,
    required this.time,
    required this.reason,
  });

  final TextEditingController acceptCommentController = TextEditingController();
  final TextEditingController rejectCommentController = TextEditingController();





    void showCommentDialog(BuildContext context, String title, TextEditingController commentController, bool accept) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                accept 
                    ? Text('Details for Meetup')
                    : Text('Reason for Rejection')
                ,
                TextField(
                  controller: commentController,
                  maxLines: 3, 
                  decoration: InputDecoration(
                    hintText: 'Enter your comment here...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children:[ ElevatedButton(
                    onPressed: () async {

                      String comment = commentController.text;

                      accept
                        ? await BaseClient().acceptAppointment('/acceptAppointment.php', pendingID, comment)
                        : await BaseClient().acceptAppointment('/rejectAppointment.php', pendingID, comment);

                      print("Comment submitted: $comment");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PendingAppointments(teachID))); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF1f1b4f),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text("Submit",
                      style: TextStyle(
                        color: Color.fromRGBO(250, 180, 23, 1),
                    ),
                  ),
                ),
                  ]
                )
              ],
            ),
          );
        },
      );





  }

  void showAcceptDialog(BuildContext context) {
    showCommentDialog(context, "Accepted", acceptCommentController, true);
  }

  void showRejectDialog(BuildContext context) {
    showCommentDialog(context, "Rejected", rejectCommentController, false);
  }


  @override
  Widget build(BuildContext context) {
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
            DateAndTimeInput(
              date: availableDate,
              time: time
            ),
            SizedBox(height: 20),
            ReasonForAppointmentInput(reason: reason,),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showAcceptDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1f1b4f),
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                      color: Color.fromRGBO(250, 180, 23, 1),
                    ),
                  ),
                ),
                SizedBox(width: 16), // Add some space between the buttons
                ElevatedButton(
                  onPressed: () {
                    showRejectDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1f1b4f), // Background color for Reject button
                  ),
                  child: const Text(
                    'Reject',
                    style: TextStyle(
                      color: Color.fromRGBO(250, 180, 23, 1),
                    ),
                  ),
                ),
              ],
            ),
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
                'Available on $availableDate\nat $time',
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

  final String date;
  final String time;

  const DateAndTimeInput({
    required this.date,
    required this.time,

    super.key});



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date: $date',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1f1b4f),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Time: $time',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1f1b4f),
          ),
        ),

      ],
    );
  }
}

class ReasonForAppointmentInput extends StatelessWidget {

  final String reason;

  const ReasonForAppointmentInput({super.key,
        required this.reason
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reason for an Appointment',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1f1b4f),
          ),
        ),
        Text(
          reason,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF1f1b4f),
          ),
          ),
      ],
    );

  }
}


