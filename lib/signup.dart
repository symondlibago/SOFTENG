import 'package:flutter/material.dart';
import 'Login.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup',
      debugShowCheckedModeBanner: false,
      home: SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isTermsAndPolicyChecked = false;

  String? validateEmail(String? value) {
    if (value == null || !value.contains('@')) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePasswordMatch(String? confirmPassword) {
    String password = passwordController.text.trim();
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text("Error"),
            ],
          ),
          content: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              clearEmailField();
            },
            child: Text(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                clearEmailField();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void SuccessAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text("Success"),
            ],
          ),
          content: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void handleSignup(BuildContext context) {
    String? email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    String? emailError = validateEmail(email);
    String? passwordMatchError = validatePasswordMatch(confirmPassword);

    if (emailError != null) {
      showAlertDialog(context, emailError);
    } else if (passwordMatchError != null) {
      showAlertDialog(context, passwordMatchError);
    } else if (!isTermsAndPolicyChecked) {
      showAlertDialog(context, "Please click the terms and policy agreement");
    } else {
      SuccessAlertDialog(context, "Sign up Successfully");
    }
  }

  void clearEmailField() {
    emailController.clear();
  }

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      obscureConfirmPassword = !obscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 125,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Signup',
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: validateEmail,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: togglePasswordVisibility,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: toggleConfirmPasswordVisibility,
                        ),
                      ),
                      validator: validatePasswordMatch,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: isTermsAndPolicyChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isTermsAndPolicyChecked = value ?? false;
                            });
                          },
                        ),
                        Text(
                          'I agree to the policy and terms',
                          style: TextStyle(
                            color: darkBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        handleSignup(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text('Sign up'),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: darkBlue,
                            thickness: 2,
                            indent: 20,
                            endIndent: 10,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or signup with',
                            style: TextStyle(
                              color: darkBlue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: darkBlue,
                            thickness: 2,
                            indent: 10,
                            endIndent: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Add your Facebook login logic here
                          },
                          icon: Image.asset(
                            'assets/Facebook_Logo.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        IconButton(
                          onPressed: () {
                            // Add your Gmail login logic here
                          },
                          icon: Image.asset(
                            'assets/gmail_logo.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        IconButton(
                          onPressed: () {
                            // Add your Twitter login logic here
                          },
                          icon: Image.asset(
                            'assets/Twitter_logo.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 425,
            child: Center(
              child: Image.asset(
                'assets/JIcon.png',
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
