import 'dart:convert';

import 'package:flutter_app/models/loginModel.dart';
import 'package:flutter_app/services/apiService.dart';

class AuthRepository{
  static APIService<ResultModel> post(url, dynamic body){
    return APIService(
      url: url,
      body: body,
      parse: (response){
        final parsed = json.decode(response.body);
        return ResultModel.fromJSON(parsed);

      }
    );
  }
}