import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:travel_app/controller/userController.dart';
import 'package:travel_app/view/AddNewItem.dart';
import 'package:travel_app/view/traelsDetails_page.dart';
import 'package:travel_app/view/updatePage.dart';
import 'package:travel_app/view/widgets/trips%20Card.dart';

import '../controller/glopal data repo.dart';
import '../controller/sendEmailController.dart';
import '../model/Trip_Data_model.dart';
import '../model/tripBookingStatus.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({Key? key}) : super(key: key);

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  void initState() {
    // SendEmailController.sendEmailFunc('abdelrhmannassr8511111@gmail.com',"$idNumb $name $phoneNumb ");
    // TODO: implement initState
    setState(() {
      UserController().Log_out_with_timer(context);
    });

    bloc.getData_trip();
    bloc.getTripStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<UnmodifiableListView<TripDataModel>>(
            initialData: UnmodifiableListView<TripDataModel>([]),
            stream: bloc.TRipsStream,
            builder: (context, snapShot) {

              return StreamBuilder<UnmodifiableListView<TripBookingStatus>>(
                  initialData: UnmodifiableListView<TripBookingStatus>([]),
                  stream: bloc.trip_booking_Data_Stream,
                  builder: (context, trip_booking_Data_Stream_snapshot) {
                    print("trip_booking_Data_Stream_snapshot ${trip_booking_Data_Stream_snapshot.data}");
                    return RefreshIndicator(
                      onRefresh: () async {
                        await bloc.getData_trip();
                        print("expiresIn${expiresIn}");
                      },
                      child: ListView.builder(
                        itemBuilder: (context, count) {

                          return TipsCard(snapShot: snapShot.data![count],
                              status:

                              trip_booking_Data_Stream_snapshot.data!
                                  .where((element) =>
                              element.TripId == snapShot.data![count].id).isEmpty != true
                                  ?
                              trip_booking_Data_Stream_snapshot.data!
                                  .firstWhere((element) =>
                              element.TripId == snapShot.data![count].id).status:null);



                        },
                        itemCount: snapShot.data!.length,
                      ),
                    );
                  }
              );
            }
        )

    );
  }
}
