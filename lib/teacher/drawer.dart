import 'package:first_project/Login.dart';
import 'package:first_project/main.dart';
import 'package:flutter/material.dart';
import '../backend.dart';
import 't_dashboard.dart';
import 't_edit_profile_screen.dart';
import 't_active_appointments.dart';
import 't_available_sched.dart';
import 't_cancel_appointment.dart';
import 't_pending.dart';

class SidebarDrawer extends StatefulWidget {

  final String ID;


  const SidebarDrawer(
      this.ID,
      {super.key});

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {

  String teachID = "";
  String name = "";
  String email = "";
  String background = "";



  @override
  void initState(){
    getUserData();

    super.initState();
  }


  getUserData() async {
    var getUser = await BaseClient().getWithID(widget.ID, "/tempLoginTeacher.php");

    setState(() {
      teachID = getUser["tID"];
      name = getUser["name"];
      email = getUser["email"];
      background = getUser["background"];
    });
  }



  @override
  Widget build(BuildContext context) => Drawer(
    child: Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(
                      'https://www.google.com/search?q=happy+octopus+and+sad+octopus+stuffed+toy&sca_esv=597709555&rlz=1C1GCEA_enPH1084PH1084&tbm=isch&sxsrf=ACQVn09YlNJZ9a4zu1lukyTw-TUJdThgOQ:1705031708746&source=lnms&sa=X&ved=2ahUKEwjTl9KK-taDAxWJ1zgGHfr_Ai0Q_AUoAXoECAEQAw&biw=1536&bih=730&dpr=1.25#imgrc=oRVXB32rkXQbzM'),
                ),
                SizedBox(height: 12),
                Text(name,
                    style:
                    TextStyle(fontSize: 28, color: Color(0xFF1f1b4f))),
                Text(email,
                    style:
                    TextStyle(fontSize: 16, color: Color(0xFF1f1b4f))),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildDrawerItem('Dashboard', Icons.home, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeachersDashboardScreen(teachID)),
                  );
                }, context),
                buildDrawerItem('Edit Profile', Icons.person, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeachEditProfile(teachID)),
                  );
                }, context),
                buildDrawerItem('My Appointment', Icons.schedule, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyAppointments(teachID,)),
                  );
                }, context),
                buildDrawerItem('My Schedule', Icons.calendar_today, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeacherSchedule(teachID, name)),
                  );
                }, context),
                buildDrawerItem('Appointment Request', Icons.check, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PendingAppointments(teachID)),
                  );
                }, context),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFF1f1b4f),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Color(0xFF1f1b4f),
                  size: 30,
                ),
                SizedBox(width: 20),
                Text(
                  'Log Out',
                  style: TextStyle(
                    color: Color(0xFF1f1b4f),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => LoginPage())
              );
            },
          ),
        ],
      ),
    ),
  );

  ListTile buildDrawerItem(String title, IconData icon, void Function() onTap,
      BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: Color(0xFF1f1b4f),
            size: 30,
          ),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF1f1b4f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyHomePage())); // Close the drawer
        onTap(); // Execute the provided onTap function
      },
    );
  }
}


