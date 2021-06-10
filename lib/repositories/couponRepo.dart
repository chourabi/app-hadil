import 'dart:convert';


import 'package:flutter_app/models/couponModel.dart';
import 'package:flutter_app/services/apiService.dart';

class CouponRepository{
  static APIService<List<CouponModel>> getCoupon(url){
    return APIService(
      
       url: url,
      parse: (response){
        final parsed = json.decode(response.body);
        final dataJson = CouponModel.fromJSON(parsed);
        var couponList = dataJson as List;
        List<CouponModel> coupons = couponList.map((i) => CouponModel.fromJSON(i)).toList();

        return coupons;
      }
    );
  }
}