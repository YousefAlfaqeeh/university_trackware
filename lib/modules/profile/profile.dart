import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sizer/sizer.dart';
import 'package:university_trackware/cubit/cubit.dart';
import 'package:university_trackware/cubit/states.dart';
import 'package:university_trackware/localizations.dart';
import 'package:university_trackware/modules/login/login.dart';
import 'package:university_trackware/shared/components/customAppBar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  bool isSwitchOn = false;
  @override
  void initState() {
    // TODO: implement initState

    isSwitchOn=AppCubit.notify==1 ? true:false;
    setState(() {

    });
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
        create: (context) => AppCubit()..getProfile(),
        child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {


            return Scaffold(
                body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff0543a4),
                  Color(0xff0543a4),
                ],
              )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppbar(  AppLocalizations.of(context)
                    .translate('menu'), Icon(Icons.arrow_back_ios, color: Colors.white)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 85.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xfff7f7fa),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          )),
                      child: Container(
                        height: 85.h,
                        // padding: EdgeInsets.only(left: 15,right: 15),

                        child: Column(
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 30, right: 15, top: 30),
                                      child: Container(
                                        // color: Colors.red,
                                        height: 80,
                                        width: 80,
                                        child: CircleAvatar(
                                            // radius: 30,
                                            backgroundImage: NetworkImage(AppCubit.image.toString())),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  25),
                                          child: Text( AppLocalizations.of(context)
                                              .translate('student_Name')
                                            ,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Nunito',
                                                color: Color(0xff888889)),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            AppCubit.name.toString(),
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff3f70ba)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // phone
                            Container(
                              height: 8.h,

                              decoration: BoxDecoration(border: Border.all(color: Colors.black,width: .3),color: Colors.white),
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xff0543a4)),
                                    height: 35,
                                    width: 35,
                                    child:
                                        Icon(Icons.phone, color: Colors.white),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text( AppLocalizations.of(context)
                                          .translate('phone')
                                       ,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                            color: Colors.black),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          AppCubit.mobile.toString(),
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins',
                                              color: Color(0xff888889)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ),
                            //Language
                            Container(
                              height: 8.h,

                              decoration: BoxDecoration(border: Border.all(color: Colors.black,width: .3),color: Colors.white),
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xff0543a4)),
                                    height: 35,
                                    width: 35,
                                    child:
                                    Icon(Icons.language, color: Colors.white),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('language')
                                     ,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal:15),
                                    child: Text(AppCubit.lang=='ar'?"عربي":
                                      "English",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),

                            ),
                            //Change Password
                            Container(
                              height: 8.h,

                              decoration: BoxDecoration(border: Border.all(color: Colors.black,width: .3),color: Colors.white),
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xff0543a4)),
                                    height: 35,
                                    width: 35,
                                    child:
                                    Icon(Icons.lock, color: Colors.white),
                                  ),
                                  Expanded(
                                    child: Text(AppLocalizations.of(context)
                                        .translate('change_Password')
                                   ,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal:15),
                                    child: Text(AppLocalizations.of(context)
                                        .translate('change')
                                      ,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff16818b)),
                                    ),
                                  ),
                                ],
                              ),

                            ),
                            //help
                            Container(
                              height: 8.h,

                              decoration: BoxDecoration(border: Border.all(color: Colors.black,width: .3),color: Colors.white),
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xff0543a4)),
                                    height: 35,
                                    width: 35,
                                    child:
                                    Icon(Icons.help, color: Colors.white),
                                  ),
                                  Expanded(
                                    child: Text( AppLocalizations.of(context)
                                        .translate('help')
                                      ,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          color: Colors.black),
                                    ),
                                  ),

                                ],
                              ),

                            ),
                            // "Notification"
                            Container(
                              height: 8.h,

                              decoration: BoxDecoration(border: Border.all(color: Colors.black,width: .3),color: Colors.white),
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xff0543a4)),
                                    height: 35,
                                    width: 35,
                                    child:
                                    Icon(Icons.notifications, color: Colors.white),
                                  ),
                                  Expanded(
                                    child: Text( AppLocalizations.of(context)
                                        .translate('notofication')
                                      ,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal:15),
                                    child:FlutterSwitch(
                                      width: 50.0,
                                      height: 30.0,
                                      valueFontSize: 25.0,
                                      toggleSize: 30.0,
                                      value: isSwitchOn,
                                      borderRadius: 30.0,
                                      padding: 1.0,
                                      activeColor: Colors.green,
                                      // showOnOff: true,
                                      onToggle: (val) {

                                        setState(() {


                                          isSwitchOn = val;
                                          AppCubit.get(context).postProfile(isSwitchOn, '', 'en');


                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),

                            ),
                            // "logout"
                            Container(
                              height: 8.h,

                              // decoration: BoxDecoration(border: Border.all(color: Colors.black,width: .3),color: Colors.white),
                              child: InkWell(
                                onTap: () {
                                  AppCubit.get(context).logout();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>LoginScreen() ),
                                );

                                },
                                child: Row(
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 20),
                                      // decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(5),
                                      //     color: Color(0xff0543a4)),
                                      height: 35,
                                      width: 35,
                                      child:
                                      Icon(Icons.logout, color: Colors.blue),
                                    ),
                                    Expanded(
                                      child: Text( AppLocalizations.of(context)
                                          .translate('logout')
                                       ,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                            color: Color(0xff2f64b4)),
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            )


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          },
          listener: (context, state) {
            isSwitchOn=AppCubit.notify==1 ? true:false;
            setState(() {

            });
          },
        ));
  }
}
