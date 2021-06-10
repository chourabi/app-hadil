import 'package:flutter_app/models/resultModel.dart';
import 'package:flutter_app/repositories/convertRepo.dart';
import 'package:flutter_app/services/apiService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MsgBloc extends Bloc<MsgEvent, MsgState>{
  



  MsgBloc(MsgState initialState) : super(initialState);


  void onConvert(int solde){
    add(ConvertirEvent(solde: solde));
  }

  
 //@override
 //AuthenticationState get initialState => AuthenticationState.initial();


  //SharedPreferences sharedPreferences;
  @override
  Stream<MsgState> mapEventToState(MsgEvent event) async* {
    if(event is ConvertirEvent){
      try{
        yield LoadingState();
        //give a delay for loading
        await Future.delayed(const Duration(seconds: 1));
        //recuperer
         int solde =event.solde;
         int id=14;
        //execute api
        var url = "bandeAchat/$id/$solde" ;
        
        final data = await APIWeb().postA(ConvertRepository.post(url));
        //retrieve data
        yield MsgState(msgModel: data);
      }catch(e){
        yield GetFailureState(e.toString());
      }
    }

   

  }

}





//event
class MsgEvent{}

class ConvertirEvent extends MsgEvent{
  final int solde;
  ConvertirEvent({this.solde});
}



//state
class MsgState{
  final MsgModel  msgModel;

  const MsgState({this.msgModel});

  factory MsgState.initial() => MsgState();
}

class GetFailureState extends MsgState{
  final String error;

  GetFailureState(this.error);
}


class LoadingState extends MsgState{}