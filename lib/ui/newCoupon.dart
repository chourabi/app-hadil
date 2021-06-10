import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/convertirBloc.dart';
import 'package:flutter_app/bloc/navigationBloc.dart';
import 'package:flutter_app/models/resultModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';

class Newcoupon extends StatefulWidget with NavigationStates {

   @override
  _NewcouponState createState() => _NewcouponState();
  }
  
  class _NewcouponState extends State<Newcoupon>{

    final textControllerPoints = TextEditingController();

     final convBloc = MsgBloc(MsgState.initial());

     //loading widget
  void messageDialog(BuildContext context, String message){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return CupertinoAlertDialog(
          title: Text(message),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("done"),
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      }
    );
  }

     @override
  Widget build(BuildContext context) {
    
    return BlocListener(
      bloc: convBloc,
      listener: (context, MsgState state){
        if(state.msgModel != null && state is MsgState){
           Navigator.of(context, rootNavigator: true).pop();
          WidgetsBinding.instance.addPostFrameCallback((_) => messageDialog(context, state.msgModel.message ))
          
          ;
          
        
        }else if(state is GetFailureState){
          Navigator.of(context, rootNavigator: true).pop();
          WidgetsBinding.instance.addPostFrameCallback((_) => messageDialog(context, "Upps... " + state.error)); 

        }
      },
    
    
    
    
    
    
    
    
    
   child: Scaffold(
      body: SafeArea(

        child: Container(
          child:CustomScrollView(
            slivers: <Widget> [
              
              SliverAppBar(
                backgroundColor: Colors.deepOrange[100] ,
                expandedHeight:MediaQuery.of(context).size.height*0.3,
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: Lottie.asset("assets/coupon1.json.json"),
                  
                  ),
                  
                  
              ),

              
              SliverList(delegate: SliverChildListDelegate(
                [Padding(
                  padding: EdgeInsets.only(top:20, left:20),
                  child: Text('TRANSFORMER VOS POINTS EN BANDES ACHATS', style:TextStyle(
                          color: Color(0xFF1000000),
                          fontSize: 25,
                          fontWeight: FontWeight.w700),)
                
                ,),
                SizedBox(height: 25),
               /* Padding(
                  padding: EdgeInsets.only(right:24, left:25, bottom: 25),
                  child: Text('',
                           style:TextStyle(
                          color: Color(0xFF1000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),)

                ,)*/
                 Padding(
                  padding: EdgeInsets.only(right:24, left:25, bottom: 25),
                  child: Text('Pour convertir votre nombre de points de fidélité , il faut avoir un solde minimum de 50 points. Le montant de votre bon d’achat est calculé selon le barème suivant :',
                           style:TextStyle(
                          color: Color(0xFF1000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),)
                
                
                
                ,),
                 Padding(
                  padding: EdgeInsets.only(right:24, left:25, bottom: 25),
                  child: Row(
                    children: [
                      Text('  1 Point = 50  millimes',
                               style:TextStyle(
                              color: Color(0xFF1000000),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),),

                               Text('               BASIC ',
                           style:TextStyle(
                          color: Color(0xFF1000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                          )
                    ],
                    
                ),
                  )
                ,
                  Padding(
                  padding: EdgeInsets.only(right:24, left:25, bottom: 25),
                  child: Row(
                    children: [
                      Text('  1 Point = 200  millimes',
                               style:TextStyle(
                              color: Color(0xFF1000000),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),),

                               Text('            SILVER ',
                           style:TextStyle(
                          color: Color(0xFF1000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                          )
                    ],
                    
                ),
                  )
                ,
                 Padding(
                  padding: EdgeInsets.only(right:24, left:25, bottom: 25),
                  child: Row(
                    children: [
                      Text('  1 Point = 400  millimes',
                               style:TextStyle(
                              color: Color(0xFF1000000),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),),

                               Text('            GOLD ',
                           style:TextStyle(
                          color: Color(0xFF1000000),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                          )
                    ],
                    
                ),
                  )
                ,
                 Padding(
                  padding: EdgeInsets.only(right:24, left:25, bottom: 25),
                  child: Text('Saisir le nombre des points à convertir au déla de 500 points :',
                           style:TextStyle(
                          color: Color(0xFF1000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),)
                
                
                
                ,),
                
                Padding(
                  padding: EdgeInsets.only(right:24, left:25, bottom: 25),
                  child: TextField(
                    decoration: InputDecoration(
                      
                      //hintText: "XX pts",
                      hintStyle:TextStyle(fontSize: 24,color: Colors.lightBlueAccent) ,
                      //labelText: "Nombre de Point",
                      //labelStyle: TextStyle(fontSize: 24,color: Colors.pink),
                      border: OutlineInputBorder(),
                      fillColor: Colors.white12,
                      filled: true
                    ),
                    keyboardType:TextInputType.numberWithOptions(),
                    controller: textControllerPoints,
                    
                  ),
                ),

                 Padding(
                   padding: EdgeInsets.only(right:24, left:25, bottom: 25),
                   child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: (){
                          //add event click
                          convBloc.onConvert(int.tryParse(textControllerPoints.text));
                        },
                        child: Text("VALIDER"),
                        color: Colors.deepOrange[100],
                        textColor: Color(0XFF2661FA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        ),
                      ),
                    ),
                ),
                 ),
                
              ]




              ))

          ],)
          
          
          
          
          
          ),
        ),


    ),);
  }
}
 

 
