import 'package:first_project/backend.dart';
import 'package:first_project/main.dart';
import 'package:first_project/student/dashboard.dart';
import 'package:first_project/teacher/t_dashboard.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'Welcome.dart';


const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void showAlertDialog(BuildContext context, String message, bool success, String ID, String position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              success
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text(success ? "Success" : "Alert"),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                print(ID);
                print(position);

                if(position == "student"){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardScreen(ID)));
                }else if(position == "teacher"){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TeachersDashboardScreen(ID)));
                }else{
                  Navigator.pop(context);
                }
                clearTextFields();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void clearTextFields() {
    usernameController.clear();
    passwordController.clear();
  }

  void handleLogin(BuildContext context) async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    var loginData = await BaseClient().login('/login.php', username, password);



    if (username.isEmpty || password.isEmpty) {
      showAlertDialog(context, "Please Fill Out Username or Password Fields.", false, "0", "");
    } else {
      loginData["success"]
          ? showAlertDialog(context, "Logged In Successfuly", true, loginData["id"], loginData["position"])
          : showAlertDialog(context, loginData["message"], false, "0", "");
      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: Stack(
        children: [
          Positioned(
            top: 5,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashPage()),
                );
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8),
                GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                Text(
                  'Glad to see you',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/JIcon.png',
                            height: 100,
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            child: TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              // Add your button press logic here
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              handleLogin(context);
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text('Login'),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 10,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'or login with',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/Facebook_Logo.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: () {
                                    // Add your Facebook login logic here
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              ClipOval(
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/gmail_logo.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: () {
                                    // Add your Gmail login logic here
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              ClipOval(
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/Twitter_logo.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: () {
                                    // Add your Twitter login logic here
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupPage()),
                              );
                            },
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
