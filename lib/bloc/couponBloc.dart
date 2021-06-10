import 'package:flutter_app/SharedInfo.dart';
import 'package:flutter_app/models/couponModel.dart';
import 'package:flutter_app/repositories/couponRepo.dart';
import 'package:flutter_app/services/apiService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {

  CouponBloc() : super(CouponState());

  @override
  Stream<CouponState> mapEventToState(CouponEvent event) async* {
    if (event is GetCouponEvent) {
      try{
        
        yield LoadingCoupon();
        //give a delay for loading
        await Future.delayed(const Duration(seconds: 1));

        //recuperer l'id de sharedpref
        
        String email =SharedInfo.getString("email");
        //execute api
        if(email != ''){
          var url = "bandeAchat/email/$email"  ;
          final data = await APIWeb().load(CouponRepository.getCoupon(url));
          yield CouponState(coupons: data);
        }else{
          print("oupsss pas de id");
       }
       

      }catch(e){
        yield FailureCoupon(e.toString());
      }
    }
  }
}

//event
abstract class CouponEvent {}

class GetCouponEvent extends CouponEvent {
  //String? name;

  //GetCategoryEvent({this.name});
}


//state
class CouponState {
  final List<CouponModel> coupons;

  const CouponState({this.coupons});

  factory CouponState.initial() => CouponState();
}

class FailureCoupon extends CouponState {
  final String error;

  FailureCoupon(this.error);
}

class LoadingCoupon extends CouponState {}