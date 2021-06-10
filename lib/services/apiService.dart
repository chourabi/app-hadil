import 'dart:io';

import 'package:flutter_app/SharedInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class APIService<T>{
  final String url;
  final dynamic body;
  T Function(http.Response response) parse;
  
  APIService({this.url, this.body, this.parse});
}

class APIWeb{
  //get method
  Future<T> load<T>(APIService<T> resource) async {

    
    String token = SharedInfo.getString("token");

    print(" saved token "+token);

    final response = await http.get(Uri.parse(apiUrl + resource.url),
     headers: { HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"});
    if(response.statusCode == 200){
      return resource.parse(response);
    }else{
      
      throw Exception(response.statusCode);
    }
  }

  //post method
  Future<T> post<T>(APIService<T> resource) async {
    Map<String, String> header = {
      "Content-Type": "application/json"
    };

    final response = await http.post(Uri.parse(apiUrl + resource.url), body: jsonEncode(resource.body), headers: header);
    if(response.statusCode == 200){
      return resource.parse(response);
    }else{
      throw Exception(response.statusCode);
    }
  }

   //post method with token
  Future<T> postA<T>(APIService<T> resource) async {
    Map<String, String> header = {
      "Content-Type": "application/json",
    };
     String token = SharedInfo.getString("token");
    final response = await http.post(Uri.parse(apiUrl + resource.url),headers: header/*{ HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"}*/);
    
    if(response.statusCode == 200){
      return resource.parse(response);
    }else{
      throw Exception(response.statusCode);
    }
  }
//update method 
Future<T> putFormData<T>(APIService<T> resource) async {
 
    String token = SharedInfo.getString("token");

    var response = await http.put(
    Uri.parse(apiUrl + resource.url), headers: { HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"}, body: jsonEncode(resource.body) );
    
    if(response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception(response.statusCode);
    }
  }
}