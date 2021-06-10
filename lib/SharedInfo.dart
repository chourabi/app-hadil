import 'package:flutter/material.dart';
import 'package:flutter_app/models/loginModel.dart';
import 'package:flutter_app/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedInfo{
   static SharedPreferences sharedPreferences;
  
  //save info logged in to shared preferences
  void sharedLoginSave(ResultModel resultModel) async {
    sharedPreferences = await SharedPreferences.getInstance();
    
    sharedPreferences.setString("token", resultModel.token);
  }

  void shareduserSave(UserModel userModel) async {
    sharedPreferences = await SharedPreferences.getInstance();
    
    sharedPreferences.setString("id", userModel.id.toString());
  }

  void save(TextEditingController textEditingController)async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", textEditingController.text);
  }

  static String getString(String key, {String defValue = ''}) {
    if (sharedPreferences == null) return defValue;
    return sharedPreferences.getString(key) ?? defValue;
  }
}