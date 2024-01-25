import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://192.168.56.1/ZestCons';



class BaseClient {

  var client = http.Client();

  Future<dynamic> getData(String api) async {
    var uri = Uri.parse(baseUrl + api);


    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }


  Future<dynamic> insertAppoint(String api, String studID, String availID, String reason) async {
    var uri = Uri.parse(baseUrl + api);

    var response = await http.post(uri, body: {

      'reason' : reason,
      'studID' : studID,
      'availID' : availID,
    });

    if (response.statusCode == 200){
      print('Added Data Successfully');
    }else{
      print('Add Failed. with code: ${response.statusCode}');
    }
  }

  Future<dynamic> getWithID(String ID, String api) async {
    var uri = Uri.parse(baseUrl + api);

    var response = await http.post(uri, body: {
      'teachID' : ID,
    });

    if (response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      print('Get Failed. with code: ${response.statusCode}');
    }
  }

  Future<dynamic> acceptAppointment(String api, String pendID, String details) async {
    var uri = Uri.parse(baseUrl + api);

    var response = await http.post(uri, body: {
      'pendID' : pendID,
      'details' : details
    });

    if (response.statusCode == 200){
      print('Added Data Successfully');
    }else{
      print('Add Failed. with code: ${response.statusCode}');
    }
  }

  Future<dynamic> updateProfile(String api, String ID, String fname, String lname, String course, String section, String dob, String about) async {
    var uri = Uri.parse(baseUrl + api);

    var response = await http.post(uri, body: {
      'ID' : ID,
      'firstName' : fname,
      'lastName' : lname,
      'course' : course,
      'section' : fname,
      'dob' : dob,
      'about' : about,
    });

    if (response.statusCode == 200){
      print('Updated Data Successfully');
    }else{
      print('Add Failed. with code: ${response.statusCode}');
    }
  }

  Future<dynamic> deleteWithID(String api, String ID) async {
    var uri = Uri.parse(baseUrl + api);

    var response = await http.post(uri, body: {
      'ID' : ID
    });

    if (response.statusCode == 200){
      print('Removed Data Successfully');
    }else{
      print('Add Failed. with code: ${response.statusCode}');
    }

  }

}
