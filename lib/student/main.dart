import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'edit_profile_screen.dart';
import 'my_schedule_screen.dart';
import 'view_schedule_screen.dart';
import 'cancel_appointment_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZestCons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}

class SidebarDrawer extends StatelessWidget {
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
                    CircleAvatar(
                      radius: 52,
                      backgroundImage: NetworkImage(
                          'https://www.google.com/search?q=happy+octopus+and+sad+octopus+stuffed+toy&sca_esv=597709555&rlz=1C1GCEA_enPH1084PH1084&tbm=isch&sxsrf=ACQVn09YlNJZ9a4zu1lukyTw-TUJdThgOQ:1705031708746&source=lnms&sa=X&ved=2ahUKEwjTl9KK-taDAxWJ1zgGHfr_Ai0Q_AUoAXoECAEQAw&biw=1536&bih=730&dpr=1.25#imgrc=oRVXB32rkXQbzM'),
                    ),
                    SizedBox(height: 12),
                    Text('Yunakels',
                        style:
                            TextStyle(fontSize: 28, color: Color(0xFF1f1b4f))),
                    Text('Yunakels@gmail.com',
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
                            builder: (context) => DashboardScreen()),
                      );
                    }),
                    buildDrawerItem('Edit Profile', Icons.person, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()),
                      );
                    }),
                    buildDrawerItem('My Schedule', Icons.schedule, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyScheduleScreen()),
                      );
                    }),
                    buildDrawerItem('View Schedule', Icons.calendar_today, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewScheduleScreen()),
                      );
                    }),
                    buildDrawerItem('Cancel Appointment', Icons.cancel, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CancelingAppointment()),
                      );
                    }),
                  ],
                ),
              ),
              Divider(
                color: Color(0xFF1f1b4f),
              ),
              ListTile(
                title: Row(
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
                  // logout action
                  Navigator.pop(context); // para close sa drawer
                },
              ),
            ],
          ),
        ),
      );

  ListTile buildDrawerItem(String title, IconData icon, void Function() onTap) {
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
      onTap: onTap,
    );
  }
}
