import 'dart:convert';


class ResultModel{
  final String token;
  final String type;
  final String message;

  ResultModel({this.token, this.type, this.message});

  //mapping json data
  factory ResultModel.fromJSON(Map<String, dynamic> jsonMap){
    
    final data = ResultModel(
      token: jsonMap["token"],
      type: jsonMap["type"],
      message: jsonMap["message"] 
    );
    return data;
  }
}