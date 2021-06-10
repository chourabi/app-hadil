import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/sideBar/sideBar_layout.dart';
import 'package:flutter_app/ui/homepage.dart';
import 'package:flutter_app/ui/listCoupon.dart';
import 'package:flutter_app/ui/login.dart';
import 'package:flutter_app/ui/loginUi.dart';
import 'package:flutter_app/ui/newCoupon.dart';
import 'package:flutter_app/ui/profil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authBloc.dart';

/*void main() {
  runApp(MyApp());
}*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  runApp(new MyApp());
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification?.body}');
  print(message.data["Title"]);
  print(message.data["Description"]);
}

class MyApp extends StatelessWidget {
  //add bloc to check status login
  final authBloc = AuthenticationBloc(AuthenticationState.initial());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    authBloc.onCheckLogin();
    return MaterialApp(
        title: 'demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        /* home: BlocListener(
        bloc: authBloc,
        listener: (context, AuthenticationState state){
          if(state is LoggedInState){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
            SideBarLayout()  
            ));
          }else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
            LoginScreen()
            ));
          }
        }
      )*/
        home: LoginScreen()
        //home: SideBarLayout(),
        //home: ListViewCoupon(),
        //home: Newcoupon()
        //home: ProfilePage()

        );
  }
}
