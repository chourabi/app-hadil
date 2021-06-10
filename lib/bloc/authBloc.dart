
import 'package:flutter_app/models/loginModel.dart';
import 'package:flutter_app/repositories/authRepo.dart';
import 'package:flutter_app/services/apiService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  



  AuthenticationBloc(AuthenticationState initialState) : super(initialState);


  void onLogin(String user, String password){
    add(LoginEvent(user: user, password: password));
  }

  void onLogOut(){
    add(LogOutEvent());
  }

  void onCheckLogin(){
    add(CheckLoginEvent());
  }

 //@override
 //AuthenticationState get initialState => AuthenticationState.initial();


  SharedPreferences sharedPreferences;
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if(event is LoginEvent){
      try{
        yield LoadingState();
        //give a delay for loading
        await Future.delayed(const Duration(seconds: 1));
        //execute api
        var url = "auth/login/";
        Map<String, dynamic> jsonBody = {
          'email': event.user.trim().toString(),
          'password': event.password.trim().toString(),
        };
        
        final data = await APIWeb().post(AuthRepository.post(url, jsonBody));

        print(data.token);
        

        //retrieve data
        yield AuthenticationState(resultModel: data);
      }catch(e){
        yield GetFailureState(e.toString());
      }
    }

    //check status login
    else if (event is CheckLoginEvent){
      //check shared info
      sharedPreferences = await SharedPreferences.getInstance();
      var data = sharedPreferences.get("token");
      if(data != null){
        yield LoggedInState();
      }else{
        yield LoggedOutState();
      }
    }

    //logout event
    else if(event is LogOutEvent){
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      yield LoggedOutState();
    }
  }

}





//event
class AuthenticationEvent{}

class LoginEvent extends AuthenticationEvent{
  final String user;
  final String password;

  LoginEvent({this.user, this.password});
}

class LogOutEvent extends AuthenticationEvent{}
class CheckLoginEvent extends AuthenticationEvent{}

//state
class AuthenticationState{
  final ResultModel  resultModel;

  const AuthenticationState({this.resultModel});

  factory AuthenticationState.initial() => AuthenticationState();
}

class GetFailureState extends AuthenticationState{
  final String error;

  GetFailureState(this.error);
}

class LoggedInState extends AuthenticationState{}
class LoggedOutState extends AuthenticationState{}
class LoadingState extends AuthenticationState{}