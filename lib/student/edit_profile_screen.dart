
import 'dart:io';
import 'package:first_project/backend.dart';
import 'package:first_project/student/dashboard.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:image_picker/image_picker.dart';


class EditProfile extends StatefulWidget {

  File? _selectedImage;

  final String studID;

 EditProfile(
     this.studID,
     {super.key});



  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  String fname = "";
  String lname = "";
  String course = "";
  String section = "";
  String dob = "";
  String about = "";

  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _course = TextEditingController();
  TextEditingController _section = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _about = TextEditingController();
  void initState(){
    fetchData();
    super.initState();
  }

  fetchData() async {
    var data = await BaseClient().getWithID(widget.studID, '/getStudentProfile.php');

    setState(() {
      fname = data["fname"];
      lname = data["lname"];
      course = data["course"];
      section = data["section"];
      dob = data["dob"];
      about = data["about"];

      _fname.text = fname;
      _lname.text = lname;
      _course.text = course;
      _section.text = section;
      _dob.text = dob;
      _about.text = about;

    });

  }


  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    print(fname);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:
            Text("Edit Profile",
            style: TextStyle(
              color: Color(0xFF1f1b4f),
              fontWeight: FontWeight.bold,
            ),
          ),
        )

      ),
      drawer: SidebarDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      child: Icon(Icons.person, size: 60.0),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: InkWell(
                        onTap: () {
                          _showImagePickerOptions();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child:
                      TextFormField(
                        controller: _fname,
                        validator: (value) {
                          if (value!.isEmpty) return "First name can't be empty";
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Name",
                          hintText: "Enter your First Name",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(child:
                      TextFormField(
                        controller: _lname,
                        validator: (value) {
                          if (value!.isEmpty) return "Last name can't be empty";
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          hintText: "Enter your Last Name",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: _course,
                  validator: (value) {
                    if (value!.isEmpty) return "Course can't be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Profession",
                    hintText: "Enter your profession",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _dob,
                  validator: (value) {
                    if (value!.isEmpty) return "DOB can't be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Date Of Birth",
                    hintText: "Enter your date of birth (yyyy/mm/dd)",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _section,
                  validator: (value) {
                    if (value!.isEmpty) return "Title can't be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "Enter your title",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _about,
                  validator: (value) {
                    if (value!.isEmpty) return "About can't be empty";
                    return null;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "About",
                    hintText: "Write about yourself",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_globalKey.currentState!.validate()) {
                      await BaseClient().updateProfile('/updateStudentProf.php',
                          widget.studID,
                          _fname.text,
                          _lname.text,
                          _course.text,
                          _section.text,
                          _dob.text,
                          _about.text
                      );

                      Navigator.push(context,
                        MaterialPageRoute(builder:
                        (context) => DashboardScreen()
                        ),
                      );
                    }

                  },
                  child: Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Take a picture'),
              onTap: () {
                _pickImageFromCam();
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Choose from gallery'),
              onTap: () {
                _pickImageFromGallery();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      widget._selectedImage = File(returnedImage!.path);
    });
  }

  Future<void> _pickImageFromCam() async {
    final returnedImage =
    await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      widget._selectedImage = File(returnedImage!.path);
    });
  }
}
