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
}
