import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/authBloc.dart';
import 'package:flutter_app/components/Background.dart';
import 'package:flutter_app/sideBar/sideBar_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SharedInfo.dart';
import '../constants.dart';


class LoginScreen extends StatefulWidget {
  //LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  final textControllerEmail = TextEditingController(),
    textControllerPassword = TextEditingController();

  bool bCheckEmail = false;
  bool bCheckPassword = false;

  final authBloc = AuthenticationBloc(AuthenticationState.initial());
  final sharedInfo = SharedInfo();
  
  //loading widget
  void loadingDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return CupertinoAlertDialog(
          title: Text("Loading..."),
          content: CupertinoActivityIndicator(radius: 15,),
        );
      }
    );
  }

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
              child: Text("ok"),
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
 Size size = MediaQuery.of(context).size;

     return BlocListener(
      bloc: authBloc,
      listener: (context, AuthenticationState state){
        if(state.resultModel != null && state is AuthenticationState){
          //dismis loading widget
          Navigator.of(context, rootNavigator: true).pop();
          //save user to shared info
          sharedInfo.sharedLoginSave(state.resultModel);
          sharedInfo.save(textControllerEmail);
          // go to main menu
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
           // HomePage()
           SideBarLayout()
          ));
          
        }else if (state is LoadingState){
          //show loading
          WidgetsBinding.instance.addPostFrameCallback((_) => loadingDialog(context)); 
        }else if(state is GetFailureState){
          Navigator.of(context, rootNavigator: true).pop();
          if(state.error == 'Exception: 401'){
            WidgetsBinding.instance.addPostFrameCallback((_) => messageDialog(context, "Upps,Bad credentials " ));
            }else{

          WidgetsBinding.instance.addPostFrameCallback((_) => messageDialog(context, "Upps, " + state.error)); 
            }
        }
      },
      child: Scaffold(body: SingleChildScrollView(
        child: Background(
          
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Fidelity",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(height: size.height * 0.03),

              
            Container(
               child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    autovalidate: true,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: textControllerEmail,
                                style: TextStyle(color: Colors.black),
                                cursorColor: cModeDarkColorFontTitle,
                                decoration: InputDecoration(
                                  focusColor: cModeDarkColorFontTitle,
                                  labelText: "Email",
                                  labelStyle: TextStyle(color: cModeDarkColorTextBoxLabel),
                                  contentPadding: EdgeInsets.all(10.0),
                                  fillColor: Colors.black,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent)
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmail,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .85, top:13),
                                    child: iconCheckEmail(),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: textControllerPassword,
                                style: TextStyle(color: Colors.black),
                                cursorColor: cModeDarkColorFontTitle,
                                decoration: InputDecoration(
                                  focusColor: Colors.white38,
                                  labelText: "Password",
                                  labelStyle: TextStyle(color: cModeDarkColorTextBoxLabel),
                                  contentPadding: EdgeInsets.all(10.0),
                                  fillColor: cModeDarkColorFontTitle,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white38)
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                validator: validatePassword,
                                obscureText: true,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .85, top:13),
                                    child: iconCheckPassword(),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot your password?", style: TextStyle(color: Colors.black45)),
                      InkWell(
                        child: Image.asset("assets/arrow-right.png"),
                        onTap: (){
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => new ForgotPasswordScreen()));
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(alignment: Alignment.topRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () {authBloc.onLogin(textControllerEmail.text, textControllerPassword.text);},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.0,
                    width: size.width * 0.5,
                    decoration: new BoxDecoration(
                      color:Colors.deepOrange[100],
                      borderRadius: BorderRadius.circular(80.0),
                     /* gradient: new LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ]
                      )*/
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.black
                      ),
                    ),
                  ),
                ),
                   
                  ),
                  SizedBox(height: 50,),
                 
                ],
              ),
            ),
          ),
            ],
          ),
        ),
      ),
      ),
    ) ;
  }

  String validatePassword(String value){
    if(value.length < 3){
      bCheckPassword = false;
      return "Must be more than 3 character!";
    }else{
      bCheckPassword = true;
      return null;
    }
  }

  String validateEmail(String value){
    Pattern regexEmailPattern = 
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(regexEmailPattern);
    if(!regex.hasMatch(value)){
      bCheckEmail = false;
      return "Not a valid email address, Should be your@email.com!";
    }else{
      bCheckEmail = true;
      return null;
    }
  }

  Widget iconCheckEmail(){
    if(_formKey.currentState == null){
      return Container();
    }else if(bCheckEmail && textControllerEmail.text.isNotEmpty){
      return Icon(Icons.check, color: Colors.deepOrange[100],);
    }else if(!bCheckEmail){
      return Icon(Icons.clear, color: Colors.red[300],);
    }else{
      return Container();
    }
  }
  
  Widget iconCheckPassword(){
    if(_formKey.currentState == null){
      return Container();
    }else if(bCheckPassword && textControllerPassword.text.isNotEmpty){
      return Icon(Icons.check, color: Colors.deepOrange[100],);
    }else if(!bCheckPassword){
      return Icon(Icons.clear, color: Colors.red[300],);
    }else{
      return Container();
    }
  }
}

