import 'package:flutter/material.dart';
import 'package:flutter_app/SharedInfo.dart';
import 'package:flutter_app/bloc/couponBloc.dart';
import 'package:flutter_app/bloc/navigationBloc.dart';
import 'package:flutter_app/components/couponComponent.dart';
import 'package:flutter_app/models/couponModel.dart';
import 'package:flutter_app/repositories/couponRepo.dart';
import 'package:flutter_app/repositories/userRepo.dart';
import 'package:flutter_app/services/apiService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
 

import '../constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

 

class ListViewCoupon extends StatefulWidget with NavigationStates {
 // BlocProductView({Key? key}) : super(key: key);

  @override
  _ListViewCouponState createState() => _ListViewCouponState();
}

class _ListViewCouponState extends State<ListViewCoupon> {

List<dynamic> _coupList = [];
 
  @override
  void initState() {
     getCupponsList();
  }

  getCupponsList() async{
    String token = SharedInfo.getString("token");
 
          final user = await APIWeb().load(UserRepository.getUser("auth/info"));

          var url = 'bandeAchat/${user.id}';


              final response = await http.get(Uri.parse(apiUrl + url),
     headers: { HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"});




      List<dynamic> x = json.decode(response.body);



          setState(() {
            _coupList = x;
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       /*appBar: AppBar(
        title: Text("Product", style: TextStyle( fontSize: 30, color: Colors.white),),
        backgroundColor: Color(0xFF2BB64C),
        elevation: 1.0,),*/
      
      body: Container(
        padding: EdgeInsets.only(top: 100),
          height: MediaQuery.of(context).size.height,
        child: ListView.builder( itemCount: _coupList.length, itemBuilder: (context, index) {
        return(
          Container(
            margin: EdgeInsets.only(top: 10,left: 15,right: 15),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('${_coupList[index]['code']}'),
                  Text('${_coupList[index]['montantBandeAchat']} DT'),
                  Text('${_coupList[index]['dateExpiration']}'),
                  
                ],
              ),
              )
            ),
          )
        );
      }, ),
      ),
          
    //],)));
    );
  }
}