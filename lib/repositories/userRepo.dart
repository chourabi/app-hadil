import 'dart:convert';

import 'package:flutter_app/models/resultModel.dart';
import 'package:flutter_app/models/userModel.dart';
import 'package:flutter_app/services/apiService.dart';

class UserRepository{
  static APIService<UserModel> getUser(url){
    return APIService(
      url: url,
      parse: (response){
        final parsed = json.decode(response.body);
        return UserModel.fromJSON(parsed);

      }
    );
  }


  static APIService<MsgModel>update(url, dynamic body){
    return APIService(
      url: url,
      body: body,
      parse: (response){
        final parsed = json.decode(response.body);
         
         return MsgModel.fromJSON(parsed);

      }
    );
  }
}