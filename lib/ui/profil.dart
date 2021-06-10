import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/SharedInfo.dart';
import 'package:flutter_app/bloc/navigationBloc.dart';
import 'package:flutter_app/bloc/userBloc.dart';
import 'package:flutter_app/components/CircularLoading.dart';
import 'package:flutter_app/components/DOBComponent.dart';
import 'package:flutter_app/components/DataItemComponent.dart';
import 'package:flutter_app/components/InkButton.dart';
import 'package:flutter_app/models/userModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget with NavigationStates  {
   @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      
      body: BlocProvider<UserBloc>(
        create:  (context) => UserBloc()..add(GetEmailEvent(email:SharedInfo.getString("email"))),
        child: ProfileDetail(),
      ) 
    );
  }
}

class ProfileDetail extends StatefulWidget {
  ProfileDetail({Key key}) : super(key: key);

  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {

  DateTime _selectedDate;

  String _selectedSex="Homme";


 bool _editMode = false;
  void messageDialogs(BuildContext ctx, String title, String message){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
            title: Center(
              child: Text(title, style: TextStyle(fontSize: 20),),
            ),
            content: Text(message),
            actions: [
              FlatButton(
                child: Text("Close"),
                onPressed: (){
                  Navigator.of(context, rootNavigator: true).pop();
                  ctx.read<UserBloc>().add(GetEmailEvent());
                },
              )
            ],
          );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<UserBloc, UserState>(
      listener: (contex, state){
        if(state is LoadingUser){
          WidgetsBinding.instance.addPostFrameCallback((_) => loadingIndicator(context, "Loading..."));
        }
        else if(state is UserState && state.user != null){
          //close show loading
          Navigator.of(context, rootNavigator: true).pop();
        }
        else if(state is FailureUser){
          Navigator.of(context, rootNavigator: true).pop(); //close loading
          WidgetsBinding.instance.addPostFrameCallback((_) => messageDialog(context, "Error", state.error));
        } else if(state is SuccessSaveUser){
          Navigator.of(context, rootNavigator: true).pop(); //close loading
          WidgetsBinding.instance.addPostFrameCallback((_) => messageDialogs(context, "Success", "Update successfully"));
          setState(() {
            _editMode = false;
          });
        }
      },
       buildWhen: (prevState, currState){
        return currState is UserState && currState.user != null || currState is SuccessSaveUser;
      },
      builder: (context, state){
    
      return Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(
                                        'assets/images/customer.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 0.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Information Personnelle',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                         InkWell(
                          onTap: (){
                            setState(() {
                              _editMode = true;
                            });
                          },
                          child:
                          // Icon(Icons.edit_location_outlined, size: 50, color: Colors.black,),
                          new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
                        ) 
                      
                                ],
                              )
                            ],
                          )),
                        (_editMode == true) ? formEdit(context, state.user) : 
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Column(
                            
                            children: <Widget>[
                               DetailItem(
                            title: "Nom",
                            value: state.user?.nom
                          ),
                          DetailItem(
                            title: "Prénom",
                            value: state.user?.prenom
                          ),
                          DetailItem(
                            title: "Email",
                            value: state.user?.email,
                          ),
                          DetailItem(
                            title: "telephone",
                            value: state.user?.telephone,
                          ), 
                          DetailItem(
                            title: "Date Naissance",
                            value:  state.user?.naissance != null ? state.user?.naissance.toString().substring(0,10) : ''),
                          Divider(),


                           
                            

                            ],
                          )),
                       
                     
                     
                     
                      
                    ]
              )
            
          ),
              ),
            ]),
        ]
    )
      );
      });
    
  }

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget formEdit(BuildContext context, UserModel user){

    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();

    firstNameController.text = user?.nom ;
    lastNameController.text = user?.prenom ;
    return Container(
      
          
      child:  Form(
        key: _formKey,
        child: Column(
          children: [
             DetailItemEditComponent(
              title: "Nom", 
              widget: Container(
                 width: 200.0,
                 height: 40,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a first name';
                    }
                    return null;
                  },
                  controller: firstNameController,
                  decoration: InputDecoration(
                    enabledBorder: new OutlineInputBorder(
                      
                      borderSide:  BorderSide(
                          color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderSide:  BorderSide(
                          color: Colors.grey, width: 5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:  BorderSide(
                          color: Colors.grey, width: 5.0),
                    ),
                    hintText: "First Name",
                  ),
                ),
              ),
            ),

            DetailItemEditComponent(
              title: "Prenom", 
              widget: Container(
                 width: 200.0,
                 height: 40,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a last name';
                    }
                    return null;
                  },
                  controller: lastNameController,
                  decoration: InputDecoration(
                       /* border: OutlineInputBorder(),
                        fillColor: Colors.white12,
                        filled: true,*/
                    enabledBorder: new OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.grey, width: 1.0),
                    ),
                    hintText: "Last Name",
                  ),
                ),
              ),
            ),
            DetailItemEditComponent(
              title: "Date Naissance", 
              widget: DateTimeFormField(
                 
  decoration: const InputDecoration(
    hintStyle: TextStyle(color: Colors.black45),
    errorStyle: TextStyle(color: Colors.redAccent),
    border: OutlineInputBorder(),
    suffixIcon: Icon(Icons.event_note),
    labelText: 'Date',
  ),
  mode: DateTimeFieldPickerMode.date,
  autovalidateMode: AutovalidateMode.always,
  validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
  onDateSelected: (DateTime value) {
    var dateOfBirth = value;

    setState(() {
      _selectedDate=value;
    });

  },
),
            ),
           /* DetailItem(
              title: "Email",
              value: user?.email,
            ),*/

            Row(
                             children: [
                                Radio(value: 'Homme', groupValue: _selectedSex, onChanged: (v){
                              setState(() {
                               _selectedSex = v;
                              });
                            }),
                            Text("Homme"),
                            
                            Radio(value: 'Femme', groupValue: _selectedSex, onChanged: (v){
                              setState(() {
                               _selectedSex = v;
                              });
                            }),
                            Text("Femme"),
                             ],
                           ),


            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                        elevation: 2.0,
                        padding: EdgeInsets.all(0.0),
                        child: InkButton(text: "Update"),
                        onPressed: () async{
                          if (_formKey.currentState.validate()) {

                            context.read<UserBloc>().add(SaveEvent( sexe: _selectedSex, naissance: _selectedDate, nom: firstNameController.text.trim(), prenom: lastNameController.text.trim()));

                          }else{
                            WidgetsBinding.instance.addPostFrameCallback((_) => messageDialog(context, "Error", "Error validation"));
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: RaisedButton(
                        onPressed: (){
                          setState(() {
                            _editMode = false;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                        elevation: 0.0,
                          padding: EdgeInsets.all(0.0),
                        child: InkButton(text: "Cancel"),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            
          ],
        ),
      ),
    );
  }


  

  
}