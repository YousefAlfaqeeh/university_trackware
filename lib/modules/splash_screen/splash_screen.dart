import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_trackware/cubit/cubit.dart';
import 'package:university_trackware/cubit/states.dart';
import 'package:university_trackware/dataBase/sqldb.dart';
import 'package:university_trackware/modules/bus%20stops/bus_stop.dart';
import 'package:university_trackware/modules/login/login.dart';
import 'package:university_trackware/modules/routes/routes.dart';
import 'package:university_trackware/shared/components/customLotte.dart';
import 'package:university_trackware/shared/local/cache_helper.dart';

class SplashScreen extends StatefulWidget
{

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // SqlDb sqlDb=SqlDb();
  @override
  void initState() {

    Timer timer = Timer(new Duration(seconds: 8), () async {
      try {
        // List<dynamic> resp = await sqlDb.readData("SELECT * FROM 'profile'");
        if(CacheHelper.getBoolean(key: 'authorization').toString().isNotEmpty && CacheHelper.getBoolean(key: 'authorization')!=null)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>BusStopScreen() ),
        );
        else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>LoginScreen() ),
          );
        }
      }catch(e)
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>LoginScreen() ),
        );
      }

    });
    super.initState();
  }
  // @override
  @override
  Widget build(BuildContext context) {
  return  BlocProvider(
    create: (context) {
      // if(CacheHelper.getBoolean(key: 'authorization')==null||CacheHelper.getBoolean(key: 'authorization').toString().isEmpty) {
      //   return AppCubit()
      //     ..getschool();
      // }

      return  AppCubit()..getschool();
    },
    child: BlocConsumer<AppCubit,AppStates>(
      builder: (context, state) {
   
        return Scaffold(
          backgroundColor: Colors.white,
          body:Container(
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.white,
            child: Stack(

                alignment: Alignment.bottomCenter,
                children: [

                  Container(
                    alignment: Alignment.center,
                    height:double.infinity,
                    child:Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomLotte('assets/lang/comp.json'),

                      ],),
                    )

                ),
                  Container(
                    height: MediaQuery.of(context).size.height/20,

                    child: Text('All copy right are reserved for Trackware' ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,),),
                  ),]

            ),
          ),


        );

      },
      listener: (context, state) {

      },
    ),

  );
  }
}