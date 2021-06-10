import 'dart:convert';

import 'package:flutter_app/models/resultModel.dart';
import 'package:flutter_app/services/apiService.dart';

class ConvertRepository{
  static APIService<MsgModel> post(url){
    return APIService(
      url: url,
      
      parse: (response){
        final parsed = json.decode(response.body);
        return MsgModel.fromJSON(parsed);

      }
    );
  }
}