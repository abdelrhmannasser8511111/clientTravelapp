import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/controller/sendEmailController.dart';
import 'package:travel_app/view/travels_page.dart';
import 'package:travel_app/view/updatePage.dart';

import '../controller/glopal data repo.dart';
import '../model/Trip_Data_model.dart';

class TravelDetails extends StatefulWidget {
  TravelDetails({ required this.snapShot});

  TripDataModel snapShot;


  @override
  State<TravelDetails> createState() => _TravelDetailsState();
}

class _TravelDetailsState extends State<TravelDetails> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    //  final intialHight=screenHeight-appBarHeight-statusBar;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff01404f),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              children: [
                Image.network(
                  "${widget.snapShot.image}",
                  fit: BoxFit.cover,
                  height: screenHeight * 0.25,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.07, right: screenWidth * 0.07),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.snapShot.name}",
                        style: TextStyle(
                            color: Color(0xff002134),
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: Text(
                          "\$${widget.snapShot.price}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color(0xff002134),
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.07, right: screenWidth * 0.07),
                  child: Text(
                    "${widget.snapShot.summary}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xff002134),
                      fontSize: screenWidth * 0.035,
                      //fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,height: screenHeight*0.07,
            child: ElevatedButton(onPressed: () async {
             await get_user_data();
              SendEmailController.sendEmailFunc( id: idNumb!, phonenumb: phoneNumb!, tripName: "${widget.snapShot.name}", name: name!).then((value)
              {
              //   bloc.get_user_Id().then((value) {
              //   print("valuevalue${value}");
              // });
                value=="OK"? bloc.get_user_Id().then((v) {
                  bloc.sendTripStatus( v,widget.snapShot.id!);
                }):null;
                showDialog(context: context, builder: (context){
                  if(value=="OK"){



                 return   AlertDialog(
                      title: Center(child: Text("تأكيد الحجز"),),
                      content: Container(child: Text("برجاءالإنتظار سيتم التواصل معك في أقرب وقت لتأكيد الحجز",textAlign: TextAlign.center,),),
                      actions: [
                        Center(child: ElevatedButton(onPressed: (){
                          Navigator.of(context).pop();
                        },
                          child: Text("ok"),),)
                      ],
                    );



                  }else{
                    return AlertDialog(
                      title: Center(child: Text("لم يتم الحجز"),),
                      content: Container(child: Text("يوجد مشكله برجاءالمحاوله في وقت لاحق",textAlign: TextAlign.center,),),
                      actions: [
                        Center(child: ElevatedButton(onPressed: (){
                          Navigator.of(context).pop();
                        },
                          child: Text("ok"),),)
                      ],
                    );
                  }

                });
                print("value ${value}");
              });
              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>TravelPage()));
            },style: ElevatedButton.styleFrom(primary: Color(0xff01404f)),
              child: Text('Book Now',style: TextStyle(color: Colors.white,fontSize: screenWidth*0.05),),),
          )
        ],
      ),
    );
    // String i;
    // checkWasBookOrNo(String done) async {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setString("check", done);
    //
    // }

  }
}
