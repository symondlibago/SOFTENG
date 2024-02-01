import 'package:first_project/Login.dart';
import 'package:first_project/main.dart';
import 'package:flutter/material.dart';
import '../backend.dart';
import 'dashboard.dart';
import 'edit_profile_screen.dart';
import 'my_schedule_screen.dart';
import 'view_schedule_screen.dart';
import 'cancel_appointment_screen.dart';

class SidebarDrawer extends StatefulWidget {

  final String ID;

  const SidebarDrawer(
      this.ID,
      {super.key});

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {

  String studID = "";
  String name = "";
  String email = "";
  String yearLevel = "";
  String program = "";


  @override
  void initState(){
    getUserData();

    super.initState();
  }


  getUserData() async {
    var getUser = await BaseClient().getWithID(widget.ID, "/tempLogin.php");

    setState(() {
     studID = getUser["studID"];
     name = getUser["name"];
     email = getUser["email"];
     yearLevel = getUser["year_lvl"];
     program = getUser["program"];
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
                        builder: (context) => DashboardScreen(studID)),
                  );
                }, context),
                buildDrawerItem('Edit Profile', Icons.person, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(studID)),
                  );
                }, context),
                buildDrawerItem('My Appointments', Icons.schedule, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyScheduleScreen(studID)),
                  );
                }, context),
                buildDrawerItem('View Schedule', Icons.calendar_today, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewScheduleScreen(studID)),
                  );
                }, context),
                buildDrawerItem('Cancel Appointment', Icons.cancel, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PendingAppointment(studID)),
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
        Navigator.pop(context); // Close the drawer
        onTap(); // Execute the provided onTap function
      },
    );
  }
}


