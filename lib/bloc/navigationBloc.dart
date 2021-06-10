import 'package:flutter_app/ui/homepage.dart';
import 'package:flutter_app/ui/listCoupon.dart';
import 'package:flutter_app/ui/newCoupon.dart';
import 'package:flutter_app/ui/profil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyProfilClickedEvent,
  NewCouponClickedEvent,
  MyCouponsClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(NavigationStates initialState) : super(initialState);

  //@override
  //NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyProfilClickedEvent:
        yield ProfilePage() ;
        break;
      case NavigationEvents.NewCouponClickedEvent:
        yield Newcoupon();
        break;
      case NavigationEvents.MyCouponsClickedEvent:
        yield ListViewCoupon();
        break;
    }
  }
}