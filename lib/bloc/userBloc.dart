import 'package:flutter_app/SharedInfo.dart';
import 'package:flutter_app/models/userModel.dart';
import 'package:flutter_app/repositories/userRepo.dart';
import 'package:flutter_app/services/apiService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'dart:io';
 

import '../constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class UserBloc extends  Bloc<UserEvent, UserState>{

  UserBloc() : super(UserState());
  
  @override 
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if(event is GetEmailEvent){
      try{
        yield LoadingUser();
        //give a delay for loading
        await Future.delayed(const Duration(seconds: 1));
        //recuperer l'email de sharedpref
        
        String email =SharedInfo.getString("email");
        //execute api
        if(email != ''){
          //+ email ;


          // get the re
              String token = SharedInfo.getString("token");

               


          

          final user = await APIWeb().load(UserRepository.getUser("auth/info"));

          var url = 'client/${user.id}';
          final data = await APIWeb().load(UserRepository.getUser(url));

          yield UserState(user: data);
        }else{
          print("oupsss pas de email");
       }
       

        

      }catch(ex){
        yield FailureUser(ex.toString());
      }
    }

    if(event is SaveEvent){
      try{
        yield LoadingUser();
        await Future.delayed(const Duration(seconds: 1));
        dynamic formData;
        var url = "client/informationPerso/15" ;
        formData = {
          'email': event.email,
          'nom': event.nom,
          'prenom': event.prenom,
          'telephone':event.telephone,
          'sexe':event.sexe,
          'date_naissance':event.naissance.toString().replaceFirst(' ', 'T'),
        };

        await APIWeb().putFormData(UserRepository.update(url,formData));

        yield SuccessSaveUser();        
      }catch(ex){
        yield FailureUser(ex.toString());
      }
    }
  }
}






//event


abstract class UserEvent {}

class GetEmailEvent extends UserEvent{
   final String email;
  
  GetEmailEvent({ this.email});
}

class SaveEvent extends UserEvent{
  
  final int id;
  final String email;
  final String nom;
  final String prenom;
  final String telephone;
  final String sexe;
  
  final DateTime naissance;
  SaveEvent({this.id,  this.email, this.nom, this.prenom, this.telephone, this.sexe, this.naissance});
}

//state
class UserState{
  final UserModel user;
  const UserState({this.user});

  factory UserState.initial() => UserState();
}

class LoadingUser extends UserState  {}
class SuccessSaveUser extends UserState  {}
class FailureUser extends UserState {
  String error;
  FailureUser(this.error);
}