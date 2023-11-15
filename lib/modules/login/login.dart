import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:university_trackware/cubit/cubit.dart';
import 'package:university_trackware/cubit/states.dart';
import 'package:university_trackware/localizations.dart';
import 'package:university_trackware/modules/bus%20stops/bus_stop.dart';
import 'package:university_trackware/shared/components/customLotte.dart';
import 'package:university_trackware/shared/local/cache_helper.dart';

class LoginScreen extends StatefulWidget
{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {

    super.initState();
  }
  // @override
  @override
  Widget build(BuildContext context) {
    TextEditingController user_name = TextEditingController(),
        pass = TextEditingController();
    return  BlocProvider(
      create: (context) {

        return  AppCubit()..getschool();
      },
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (context, state) {

          return Scaffold(
            backgroundColor: Colors.white,
            body:SingleChildScrollView(
              child: Container(
                // height: 100.h,
                color: Colors.white,
                child:


                Stack(
                      children: [

                        Center(child: Column(children: [

                          // SizedBox(height: 5.h,),
                          Image(image: AssetImage('images/unvers.png'),height: 200,width: 300),
                          SizedBox(height: 5.h,),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              child: TextFormField(
                                  validator: (value) {
                                    if (value?.length == 0) {
                                      Navigator.pop(context);
                                      return "please enter your user name";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText:
                                      AppLocalizations.of(context)
                                          .translate('user_name'),
                                      filled: true,
                                      //<-- SEE HERE
                                      fillColor: Colors.white,
                                      prefixIcon:
                                      const Icon(Icons.person_pin),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 2,
                                              color: Color(0xffefefef)),
                                          borderRadius:
                                          BorderRadius.circular(15)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffefefef)),
                                          borderRadius:
                                          BorderRadius.circular(15))),
                                  controller: user_name
                              )),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              child: TextFormField(
                                validator: (value) {
                                  if (value?.length == 0) {
                                    // return "please enter your Password";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .translate('password'),
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(Icons.lock),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(width: 2,
                                            color: Color(0xffefefef)),
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffefefef)),
                                        borderRadius:
                                        BorderRadius.circular(15))),

                                controller: pass,
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(
                               horizontal: 25),
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('forgot_password'),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                          SizedBox(height: 9.h,),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 50, horizontal: 20),

                            decoration: BoxDecoration(
                                color: Color(0xff0543a4),
                                borderRadius: BorderRadius.circular(10)),
                            width: double.infinity,
                            // color: Colors.orange,
                            child: MaterialButton(
                              child: Text(

                                    style: TextStyle(color: Colors.white),
                                  AppLocalizations .of(context)
                                  .translate('login_button')

                              ),
                              onPressed: () async {
                                if(user_name.text.isNotEmpty && pass.text.isNotEmpty)
                                AppCubit.get(context).Login(user_name.text, pass.text, 'tst').then((value) {
                                  print(AppCubit.get(context).status.toLowerCase());
                                  if(AppCubit.get(context).status.toLowerCase()=='connection')
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>BusStopScreen() ),
                                  );
                                },).onError((error, stackTrace) {

                                });

                              },
                            ),
                          ),
                          // SizedBox(height: 5.h,),
                          Text(

                            style: TextStyle(color: Colors.black),
                            AppLocalizations.of(context)
                            .translate('powerd_by')
                          ),
                          // SizedBox(height: 10.h,),
                          Image.asset('images/unvers.png',alignment: Alignment.bottomCenter,width: 200,height: 100,),
                        ]),)


                  ],
                ),
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