import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/couponBloc.dart';
import 'package:flutter_app/models/couponModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CircularLoading.dart';

class CouponComponent extends StatelessWidget {
  const CouponComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponBloc, CouponState>(
      listener: (BuildContext context, CouponState state){
        
      },
        builder: (context, state){
          if(state is LoadingCoupon){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircularLoading(),
            ]
          );
        }else if(state is FailureCoupon){
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('${state.error}'),
                ),
              ]
          );
        }
          if(state is CouponState){
            if(state.coupons == null){
              return Column(
                children: [
                  CircularLoading(),
                ]
              ); 
            }else{
              List<CouponModel> couponModel = state.coupons;
              return ListView(
                // shrinkWrap: true,
                padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: List.generate(
                  couponModel.length,
                  (index) {
                    return InkWell(
                      onTap: (){
                        
                        
                        
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical:5.0 ),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: Container(
                            width:MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical:5.0 ),
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween, 
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50.0,
                                      height: 50.0,
                                      color: Colors.cyan,
                                    ),
                                    SizedBox(width: 5.0,),
                                    Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(couponModel[index].code.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                         Text(couponModel[index].dateExpiration.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                       ],
                                    )
                                  ],

                                )
                              ],

                            ),
                          ), 

                        ),
                        
                      ),
                    );
                  },
                ),
                
              );
               
            }
          }else{
            return Column(
              children: [
                CircularLoading(),
              ]
            );
          }
        },
    );
  }
}