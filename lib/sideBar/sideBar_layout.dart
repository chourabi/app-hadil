import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/navigationBloc.dart';
import 'package:flutter_app/sideBar/sideBar.dart';
import 'package:flutter_app/ui/homepage.dart';
import 'package:flutter_app/ui/newCoupon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(HomePage()),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(),
          ],
        ),
      ),
    );
  }
}