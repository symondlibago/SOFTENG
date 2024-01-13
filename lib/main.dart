import 'package:flutter/material.dart';
import 'student/drawer.dart';
import 'student/dashboard.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Type'),
      ),
      drawer: SidebarDrawer(), // Include the drawer here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
              child: Text('Studeeeent'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Teacher button pressed');
              },
              child: Text('Teacher'),
            ),
          ],
        ),
      ),
    );
  }
}
