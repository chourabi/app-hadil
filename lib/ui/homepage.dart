import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/SharedInfo.dart';
import 'package:flutter_app/bloc/navigationBloc.dart';
import 'package:flutter_app/bloc/userBloc.dart';
import 'package:flutter_app/components/CircularLoading.dart';
import 'package:flutter_app/services/apiService.dart';
import 'package:flutter_app/ui/NotificationsPage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../constants.dart';


import 'dart:io';
 

import '../constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class HomePage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SalesData> _chartData;
  TooltipBehavior _tooltipBehavior;

  

  List<dynamic> notifications = [];
  List<dynamic> _notifList = [];

  


  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);

    initializeFirebaseMessaging();

    super.initState();

    initNotifCounter();
  }


  initNotifCounter() async {
        String token = SharedInfo.getString("token");

    print(" saved token "+token);

    final response = await http.get(Uri.parse(apiUrl + 'auth/info'),
     headers: { HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json"});




      List<dynamic> x = json.decode(response.body)['notifications'];

     
      List<dynamic> last = [];
      List<dynamic> allNotif = [];
       
      for(int i =0; i< x.length;i++){
        var e  = x[i];
        print(e['seen']);


        if( e['seen'] == false ){
          last.add(e);
        }

        allNotif.add(e);
      }

      setState(() {
        notifications = last;
        _notifList = allNotif;
      }); 


      print("length is ${_notifList.length}");

      
  }

  initializeFirebaseMessaging() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    firebaseMessaging.subscribeToTopic("All").then((value) {
      print("Subscribed to All");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage");
      print(message.data["Title"]);
      print(message.data["Description"]);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp");
      print(message.data["Title"]);
      print(message.data["Description"]);
    });

    Future<void> firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      print("onMessageOpenedApp");
      print(message);
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mC,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 25),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "     Fidelity ",
                style: TextStyle(
                    color: Color(0XFF2661FA),
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto'),
              ),
              // IconButton(icon: , onPressed: onPressed)
              Stack(
                children: [
                  
                  Positioned(child: IconButton(
                    icon: Icon(Icons.notifications,size: 50,),
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => NotificationsPage(notifications: _notifList,),));
                    },
                  )),
                  
                  notifications.length != 0 ?
                  Positioned(
                    
                    top: 6,
                    left: 10,
                    child: Container(
                      child: Center(child: Text( '${notifications.length}', style: TextStyle(color: Colors.white), ),),
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.red.shade500,
                    ),
                    
                    height: 29,
                    width: 29,
                  )):
                  Container()
                  


                ],
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc()..add(GetEmailEvent()),
            child: CreditCard(),
          ),
          SizedBox(
            height: 25,
          ),
          SfCartesianChart(
            title: ChartTitle(
                text: '         Votre historique',
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),

            //legend: Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              LineSeries<SalesData, double>(
                  name: 'Sales',
                  dataSource: _chartData,
                  xValueMapper: (SalesData sales, _) => sales.jour,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ],
            primaryXAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            primaryYAxis: NumericAxis(
              labelFormat: '{value}pts',
              // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)
            ),
          ),
        ]),
      ),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      //SalesData(28, 25),
      SalesData(31, 90),
      SalesData(25, 250),
      SalesData(20, 100),
      SalesData(10, 50)
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.jour, this.sales);
  final double jour;
  final double sales;
}

class CreditCard extends StatefulWidget {
  CreditCard({Key key}) : super(key: key);

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(listener: (contex, state) {
      if (state is LoadingUser) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => loadingIndicator(context, "Loading..."));
      } else if (state is UserState && state.user != null) {
        //close show loading
        Navigator.of(context, rootNavigator: true).pop();
      } else if (state is FailureUser) {
        Navigator.of(context, rootNavigator: true).pop(); //close loading
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => messageDialog(context, "Error", state.error));
      }
    }, buildWhen: (prevState, currState) {
      return currState is UserState && currState.user != null;
    }, builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: nMbox,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('loyality balance',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(state.user?.solde.toString() + ' pts',
                    style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontSize: 35,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Category',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.w700)),
                    Text('Gold',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Code',
                        style: TextStyle(
                            color: fCL,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                    Text('XXXX',
                        style: TextStyle(
                            color: fCD,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}

class NMButton extends StatelessWidget {
  final bool down;
  final IconData icon;
  const NMButton({this.down, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: down ? nMboxInvert : nMbox,
      child: Icon(
        icon,
        color: down ? fCD : fCL,
      ),
    );
  }
}
